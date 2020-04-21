import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermsProvider extends ChangeNotifier {
  static getPermStatus() async {
    print("Checking permission status ...");
    var status = await Permission.locationWhenInUse.status;
    if (status.isGranted) {
      print("Location granted");
      return true;
    } else {
      print("Location denied or unknown");
      return false;
    }
  }

  static requestPerm() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.locationWhenInUse,
    ].request();
    return statuses[Permission.locationWhenInUse];
  }

  static openSettings() {
    openAppSettings();
  }
}
