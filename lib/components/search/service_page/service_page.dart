import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/components/core/title_text.dart';
import 'package:nextbussg/utils/extensions.dart';

class ServicePage extends StatelessWidget {
  final String service;
  ServicePage({this.service});

  var serviceTypes = {
    0: "Loop",
    1: "One-way",
    2: "Two-way",
  };

  // gets the routes for the service provided
  getRoutes() async {
    String jsonString = await rootBundle.loadString('assets/services.json');
    Map serviceData = json.decode(jsonString)[service];

    print(serviceData);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRoutes(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        PageTemplate(
          showBackButton: true,
          children: [
            TitleText(title: "Bus $service").sliverToBoxAdapter(),
          ],
        );
      },
    );
  }
}
