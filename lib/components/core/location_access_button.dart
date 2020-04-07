import 'package:flutter/material.dart';
import 'package:nextbussg/components/core/buttons/button.dart';
import 'package:nextbussg/providers/locationPerms.dart';
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


class OpenLocationSettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocationPermissionsProvider locationPermissionsProvider =
        Provider.of<LocationPermissionsProvider>(context, listen: false);
    return Button(
      text: "Open location settings",
      color: Theme.of(context).errorColor,
      onTap: () {
        locationPermissionsProvider.openLocationSettings();
      },
    );
  }
}
