import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/guardian_models.dart';
import '../services/firestore_service.dart';

final familyInviteProvider = FutureProvider<FamilyAccount>((ref) => ref.watch(firestoreServiceProvider).getOrCreateFamilyForCurrentUser());

class PairingScreen extends ConsumerWidget {
  const PairingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyInvite = ref.watch(familyInviteProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Pair child device')),
      body: familyInvite.when(
        data: (family) => _PairingInvite(family: family),
        error: (error, _) => _PairingError(message: error.toString(), onRetry: () => ref.invalidate(familyInviteProvider)),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _PairingInvite extends StatelessWidget {
  const _PairingInvite({required this.family});

  final FamilyAccount family;

  @override
  Widget build(BuildContext context) {
    final qrData = Uri(
      scheme: 'guardian-parent',
      host: 'pair',
      queryParameters: {'family': family.id, 'code': family.inviteCode},
    ).toString();

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Invite for ${family.name}', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        const Text('Share this invite only with the child device owner. Pairing remains pending until a guardian approves it.'),
        const SizedBox(height: 24),
        Center(child: QrImageView(data: qrData, size: 220)),
        const SizedBox(height: 12),
        Center(child: Text(family.inviteCode, style: Theme.of(context).textTheme.displaySmall)),
        const SizedBox(height: 8),
        Center(child: Text('Family ID: ${family.id}', style: Theme.of(context).textTheme.bodySmall)),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.verified_user),
          title: Text('Parent approval required'),
          subtitle: Text('The child app must disclose permissions and request consent before activation.'),
        ),
      ],
    );
  }
}

class _PairingError extends StatelessWidget {
  const _PairingError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48),
          const SizedBox(height: 12),
          Text('Could not load your family invite.', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          FilledButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh), label: const Text('Try again')),
        ],
      ),
    ),
  );
}
