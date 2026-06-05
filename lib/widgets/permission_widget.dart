import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';


class PermissionWidget {
  Future<void> requestPermission() async {

    PermissionStatus notificationStatus =
    await Permission.notification.request();

    if (notificationStatus.isGranted) {

      debugPrint("Notification Permission Granted");

    } else if (notificationStatus.isDenied) {

      debugPrint("Notification Permission Denied");

    } else if (notificationStatus.isPermanentlyDenied) {

      openAppSettings();
    }
  }
}