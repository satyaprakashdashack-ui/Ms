import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/guardian_models.dart';
import 'auth_service.dart';

final firestoreProvider = Provider((_) => FirebaseFirestore.instance);
final firestoreServiceProvider = Provider((ref) => FirestoreService(ref.watch(firestoreProvider), ref));

class FirestoreService {
  FirestoreService(this._db, this._ref);
  final FirebaseFirestore _db;
  final Ref _ref;

  String get _uid => _ref.read(firebaseAuthProvider).currentUser!.uid;

  Stream<List<ChildDevice>> childDevices(String familyId) => _db.collection('families/$familyId/devices').snapshots().map((s) => s.docs.map((d) => ChildDevice.fromJson(d.id, d.data())).toList());

  Future<String> createFamily(String name) async {
    final code = (100000 + Random.secure().nextInt(899999)).toString();
    final doc = await _db.collection('families').add({'name': name, 'inviteCode': code, 'createdBy': _uid, 'createdAt': FieldValue.serverTimestamp()});
    await doc.collection('members').doc(_uid).set({'role': FamilyRole.owner.name, 'joinedAt': FieldValue.serverTimestamp()});
    return doc.id;
  }

  Future<FamilyAccount> getOrCreateFamilyForCurrentUser() async {
    final existing = await _db.collection('families').where('createdBy', isEqualTo: _uid).limit(1).get();
    if (existing.docs.isNotEmpty) {
      final doc = existing.docs.first;
      return FamilyAccount.fromJson(doc.id, doc.data());
    }

    final user = _ref.read(firebaseAuthProvider).currentUser;
    final familyName = _familyNameFor(user?.displayName ?? user?.email);
    final familyId = await createFamily(familyName);
    final family = await _db.doc('families/$familyId').get();
    return FamilyAccount.fromJson(family.id, family.data()!);
  }

  Future<void> requestPairing({required String familyId, required String childName, required Map<String, Object?> deviceInfo}) async {
    await _db.collection('families/$familyId/pairingRequests').add({'childName': childName, 'deviceInfo': deviceInfo, 'status': PairingStatus.pendingParentApproval.name, 'requestedAt': FieldValue.serverTimestamp(), 'consent': true});
  }

  Future<void> approvePairing(String familyId, String requestId) async {
    final request = await _db.doc('families/$familyId/pairingRequests/$requestId').get();
    final data = request.data()!;
    await _db.collection('families/$familyId/devices').add({...data['deviceInfo'] as Map<String, dynamic>, 'childName': data['childName'], 'status': PairingStatus.approved.name, 'approvedBy': _uid, 'lastOnline': DateTime.now().toIso8601String()});
    await request.reference.update({'status': PairingStatus.approved.name, 'approvedBy': _uid});
  }

  Future<void> saveRules(String familyId, String deviceId, DeviceRule rules) => _db.doc('families/$familyId/devices/$deviceId/rules/current').set(rules.toJson(), SetOptions(merge: true));

  String _familyNameFor(String? ownerName) {
    final normalized = ownerName?.trim();
    if (normalized == null || normalized.isEmpty) return 'My family';
    final firstPart = normalized.split('@').first.trim();
    return firstPart.isEmpty ? 'My family' : '$firstPart family';
  }
}
