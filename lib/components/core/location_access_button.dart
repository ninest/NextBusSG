import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:nextbussg/components/core/buttons/button.dart';
import 'package:nextbussg/utils/location_perms.dart';
import 'package:nextbussg/utils/strings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class LocationAccessButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Button(
      text: "Grant location access",
      onTap: () {
        _requestLocationAccess(context);
      },
    );
  }

  _requestLocationAccess(context) async {
    print('Location button pressed');
    // ask for permission

    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions(
      [PermissionGroup.locationWhenInUse],
    ).then(
      (statuses) {
        final status = statuses[PermissionGroup.locationWhenInUse];

        if (status == PermissionStatus.granted) {
          BotToast.showText(
            text: "Thank you for granting the permission!",
            contentColor: Theme.of(context).primaryColor,
          );
        } else {
          BotToast.showText(
            text: "Permission not granted. Please go to your settings to enable location access.",
            contentColor: Colors.red
          );
        }
      },
    );
  }
}
