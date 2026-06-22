import 'dart:io';

import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {
  Future<Map<String, Object?>> collectSnapshot() async {
    final android = Platform.isAndroid ? await DeviceInfoPlugin().androidInfo : null;
    final battery = await Battery().batteryLevel;
    final network = (await Connectivity().checkConnectivity()).map((e) => e.name).join(',');
    return {
      'model': android?.model ?? 'Unknown',
      'androidVersion': android?.version.release ?? 'Unknown',
      'battery': battery,
      'network': network,
      'lastOnline': DateTime.now().toIso8601String(),
      'storageUsage': 'Collected by native Android implementation',
      'ramUsage': 'Collected by native Android implementation',
    };
  }
}
