import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:nextbussg/components/core/buttons/button.dart';
import 'package:nextbussg/providers/locationPerms.dart';
import 'package:nextbussg/utils/location_perms.dart';
import 'package:nextbussg/utils/strings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class LocationAccessButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocationPermissionsProvider locationPermissionsProvider =
        Provider.of<LocationPermissionsProvider>(context, listen: false);
    return Button(
      text: "Grant location access",
      onTap: () {
        locationPermissionsProvider.requestPermission();
      },
    );
  }
}
