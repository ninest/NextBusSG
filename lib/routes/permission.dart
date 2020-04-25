import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hive/hive.dart';
import 'package:nextbussg/components/core/buttons/button.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/providers/location_perms.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/tabbed_app.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:nextbussg/components/core/title_text.dart';
import 'package:nextbussg/utils/route.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      children: <Widget>[
        Column(
          children: <Widget>[
            TitleText(title: "One more step ..."),
            Spacing(height: Values.marginBelowTitle),
            MarkdownBody(
                data:
                    "Please grant location permissions. It is **required** by NextBus SG to find bus stops nearby."),
            Spacing(height: Values.marginBelowTitle),
            _RequestPermissionButton(),
            Spacing(height: Values.marginBelowTitle),
            _OpenSettingsButton(),
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
          BotToast.showText(
              text: "Thank you for giving permissions!",
              contentColor: Theme.of(context).accentColor);

          // not first launch as permission settings given already
          var settingsBox = Hive.box('settings');
          settingsBox.put('first_launch', false);

          Routing.openFullScreenDialog(context, TabbedApp());
        } else {
          print("Location permission NOT GIVEN");

          // should not be able to leave this screen if no location permissions given
          BotToast.showText(
              text: "Location permisison required for app!",
              contentColor: Theme.of(context).errorColor);
        }
      },
    );
  }
}

class _OpenSettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Button(
        text: "Open location settings",
        onTap: () {
          LocationPermsProvider.openSettings();
        },
        color: Colors.grey,
      ),
    );
  }
}
