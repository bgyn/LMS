import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static final PermissionHandler _instance = PermissionHandler.init();

  PermissionHandler.init() {
    _requestNotificationPermission();
  }

  factory PermissionHandler() {
    return _instance;
  }

  Future<void> _requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;

    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }
}
