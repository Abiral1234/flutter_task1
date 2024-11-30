import 'package:permission_handler/permission_handler.dart';

Future<void> requestNotificationPermission() async {
  if (await Permission.notification.request().isGranted) {
  } else {
    // await requestNotificationPermission();
  }
}
