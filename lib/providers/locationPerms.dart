import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:nextbussg/utils/strings.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionsProvider extends ChangeNotifier {
  // returns true if granted, false otherwise
  get getBoolPermissionStatus async {
    print("Getting perm status for Home widget build");
    PermissionStatus status =
        await PermissionHandler().checkPermissionStatus(PermissionGroup.locationWhenInUse);
    print(status);
    if (status == PermissionStatus.granted)
      return true;
    else
      return false;
  }

  // sets the value of status (granted, denied, or unkown)
  // and notifies listeners, which will receive boolPermissionStatus
  void setPermissionsStatus() {
    PermissionHandler().checkPermissionStatus(PermissionGroup.locationWhenInUse).then(
      (PermissionStatus status) {
        print("Location status: $status");
        notifyListeners();
      },
    );
  }

  bool _permDenied = false;
  bool get permDenied => _permDenied;

  void requestPermission() {
    PermissionHandler().requestPermissions([PermissionGroup.locationWhenInUse]).then(
      (Map<PermissionGroup, PermissionStatus> statuses) {
        final status = statuses[PermissionGroup.locationWhenInUse];
        print("Requested location perm.");
        print("Result: $status");

        if (status == PermissionStatus.denied) {
          print("Denied location access, show go to settings button");
          BotToast.showText(text: Strings.locationPermissionDenied, contentColor: Colors.red);

          _permDenied = true;
        }

        notifyListeners();
      },
    );
  }


  void openLocationSettings() {
    PermissionHandler().openAppSettings();
  }
}
