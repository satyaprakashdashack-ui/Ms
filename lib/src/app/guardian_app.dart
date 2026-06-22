import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/auth_screen.dart';
import '../child/child_setup_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../pairing/pairing_screen.dart';
import '../permissions/permissions_screen.dart';
import '../settings/settings_screen.dart';
import '../services/auth_service.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authStateProvider);
  return GoRouter(
    initialLocation: '/dashboard',
    redirect: (context, state) {
      final signedIn = auth.valueOrNull != null;
      final loggingIn = state.matchedLocation == '/login';
      if (!signedIn && !loggingIn) return '/login';
      if (signedIn && loggingIn) return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const AuthScreen()),
      GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
      GoRoute(path: '/pair', builder: (_, __) => const PairingScreen()),
      GoRoute(path: '/child-setup', builder: (_, __) => const ChildSetupScreen()),
      GoRoute(path: '/permissions', builder: (_, __) => const PermissionsScreen()),
      GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
    ],
  );
});

class GuardianApp extends ConsumerWidget {
  const GuardianApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Guardian Parent',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff2f80ed)),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff7cc7ff), brightness: Brightness.dark),
      ),
      routerConfig: router,
    );
  }
}
