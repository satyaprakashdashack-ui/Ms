import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Production builds upload consented telemetry and evaluate local rules here.
    return true;
  });
}

class BackgroundTasks {
  static Future<void> initialize() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    await Workmanager().registerPeriodicTask('guardian-heartbeat', 'syncDeviceStatus', frequency: const Duration(minutes: 15));
  }
}
