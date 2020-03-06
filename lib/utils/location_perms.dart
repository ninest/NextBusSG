import 'package:location_permissions/location_permissions.dart';


class LocationPerms {
  static Future requestPermission() async {
    PermissionStatus permission = await LocationPermissions().requestPermissions();
    return permission;
  }

  static Future<bool> checkPermissionStatus() async {
    PermissionStatus permission = await LocationPermissions().checkPermissionStatus();
    print(permission);
    if (permission == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}