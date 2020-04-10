import 'package:flutter/material.dart';
import 'package:nextbussg/components/core/buttons/button.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/providers/home_rebuilder.dart';
import 'package:nextbussg/providers/location_perms.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:nextbussg/components/core/title_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class PermissionRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      children: <Widget>[
        Column(
          children: <Widget>[
            TitleText(title: "Please grant location permissions ..."),
            Spacing(height: Values.marginBelowTitle),
            _RequestPermissionButton()
          ],
        ).sliverToBoxAdapter(),
      ],
    ).scaffold();
  }
}

class _RequestPermissionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Button(
      text: "Grant permission",
      onTap: () async {
        var status = await LocationPermsProvider.requestPerm();

        if (status == PermissionStatus.granted) {
          print("Location permission given");
          final HomeRebuilderProvider homeRebuilderProvider =
              Provider.of<HomeRebuilderProvider>(context, listen: false);
          homeRebuilderProvider.rebuild();
        } else {
          print("Location permission NOT GIVEN");
        }
      },
    );
  }
}
