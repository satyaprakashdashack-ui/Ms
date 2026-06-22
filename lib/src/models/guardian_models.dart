enum FamilyRole { owner, guardian, child }
enum PairingStatus { pendingParentApproval, approved, rejected, revoked }

class FamilyAccount {
  const FamilyAccount({required this.id, required this.name, required this.inviteCode, required this.createdBy});
  final String id;
  final String name;
  final String inviteCode;
  final String createdBy;
  Map<String, Object?> toJson() => {'name': name, 'inviteCode': inviteCode, 'createdBy': createdBy};
}

class ChildDevice {
  const ChildDevice({required this.id, required this.childName, required this.model, required this.androidVersion, required this.lastOnline, required this.battery, required this.status});
  final String id;
  final String childName;
  final String model;
  final String androidVersion;
  final DateTime lastOnline;
  final int battery;
  final PairingStatus status;
  factory ChildDevice.fromJson(String id, Map<String, dynamic> json) => ChildDevice(
    id: id,
    childName: json['childName'] as String? ?? 'Child',
    model: json['model'] as String? ?? 'Unknown Android',
    androidVersion: json['androidVersion'] as String? ?? 'Unknown',
    lastOnline: DateTime.tryParse(json['lastOnline'] as String? ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0),
    battery: (json['battery'] as num?)?.round() ?? 0,
    status: PairingStatus.values.firstWhere((e) => e.name == json['status'], orElse: () => PairingStatus.pendingParentApproval),
  );
}

class DeviceRule {
  const DeviceRule({this.dailyLimitMinutes = 120, this.schoolMode = false, this.studyMode = false, this.bedtimeMode = false, this.blockedApps = const [], this.allowedApps = const []});
  final int dailyLimitMinutes;
  final bool schoolMode;
  final bool studyMode;
  final bool bedtimeMode;
  final List<String> blockedApps;
  final List<String> allowedApps;
  Map<String, Object?> toJson() => {'dailyLimitMinutes': dailyLimitMinutes, 'schoolMode': schoolMode, 'studyMode': studyMode, 'bedtimeMode': bedtimeMode, 'blockedApps': blockedApps, 'allowedApps': allowedApps};
}
