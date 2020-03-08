import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nextbussg/components/core/location_access_button.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/components/core/title_text.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PermissionStatus _status;
  List<Widget> _widgetOrder = [Text('Loading ...').sliverToBoxAdapter()];

  @override
  void initState() {
    super.initState();
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationWhenInUse)
        .then(_updateStatus);
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(children: [..._widgetOrder]);
  }

  Future _updateStatus(PermissionStatus status) {
    print("Current permission status: $status");

    if (status != PermissionStatus.granted) {
      // permission not granted or unknwon
      _widgetOrder = [
        TitleText(
          title: "Location permission required ...",
        ).sliverToBoxAdapter(),

        Spacing(height: Values.marginBelowTitle).sliver(),

        Text("We require your location to find all the bus stops nearby!").sliverToBoxAdapter(),

        Spacing(height: Values.marginBelowTitle).sliver(),

        LocationAccessButton().sliverToBoxAdapter(),
      ];
      setState(() {});
    } else {
      // permission granted, show UI
      _widgetOrder = [Text('Thanks for the permission').sliverToBoxAdapter()];
      setState(() {});
    }
  }
}
