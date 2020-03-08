import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:nextbussg/components/core/buttons/button.dart';
import 'package:nextbussg/utils/location_perms.dart';
import 'package:nextbussg/utils/strings.dart';
import 'package:provider/provider.dart';

class LocationAccessButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Button(
      text: "Grant location access",
      onTap: () => _requestLocationAccess(context),
    );
  }

  _requestLocationAccess(context) async {
    print('Location button pressed');
    // ask for permission
    // TODO
  }
}
