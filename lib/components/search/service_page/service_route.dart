import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/components/search/service_page/bus_stop_button.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/extensions.dart';

class ServiceRoute extends StatelessWidget {
  const ServiceRoute({Key key, @required this.route}) : super(key: key);
  final Map route;

  @override
  Widget build(BuildContext context) {

    print(route['stops']);

    List<Widget> children = [
      // spacing at top
      Spacing(height: Values.marginBelowTitle),

      Text(
        route["name"].trim(),
        style: Theme.of(context).textTheme.display1.copyWith(fontSize: Values.em * 1.5),
      ),

      for (var busStop in route["stops"])
        BusStopButton(
          code: busStop["code"],
          name: busStop["name"],
          mrtStations: busStop["mrt_stations"],
        ),

      // spacing at end of route
      Spacing(height: Values.marginBelowTitle),
    ];

    return Column(children: children).sliverToBoxAdapter();
  }
}
