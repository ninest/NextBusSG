import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nextbussg/components/core/loading/circular_spinner.dart';
import 'package:nextbussg/components/core/mrt_stations.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/components/core/title_text.dart';
import 'package:nextbussg/components/search/stop_page/stop_overview_page.dart';
import 'package:nextbussg/styles/tile_color.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:nextbussg/utils/route.dart';

class ServicePage extends StatelessWidget {
  final String service;
  ServicePage({this.service});

  final Map serviceTypes = {
    "0": "Loop",
    "1": "One-way",
    "2": "Two-way",
  };

  // gets the routes for the service provided
  Future getRoutes() async {
    String servicesJsonString = await rootBundle.loadString('assets/services.json');
    String stopsJsonString = await rootBundle.loadString('assets/bus_stops.json');
    Map serviceData = json.decode(servicesJsonString)[service];
    Map stopData = json.decode(stopsJsonString);

    /* 
    Changing route array from <int>[] to <Map>[]
    with code, name, mrt_stations
    */
    for (var route in serviceData["routes"]) {
      List newStops = [];
      for (var stopNo in route["stops"]) {
        newStops.add({
          "code": stopNo,
          "name": stopData[stopNo]["name"],
          "mrt_stations": stopData[stopNo]["mrt_stations"],
        });
      }

      route["stops"] = newStops;
    }

    return serviceData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRoutes(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return PageTemplate(
          showBackButton: true,
          children: [
            TitleText(title: "Bus $service").sliverToBoxAdapter(),
            if (snapshot.hasData) Text(serviceTypes[snapshot.data["type"]]).sliverToBoxAdapter(),
            Spacing(
              height: Values.marginBelowTitle,
            ).sliver(),
            if (snapshot.hasData)
              for (var route in snapshot.data["routes"]) serviceRoute(context, route)
            else
              CircularSpinner().sliverToBoxAdapter()
          ],
        ).scaffold();
      },
    );
  }

  serviceRoute(context, Map route) {
    List<Widget> children = [
      Text(
        route["name"].trim(),
        style: Theme.of(context).textTheme.display1,
      ),

      for (var busStop in route["stops"])
        busStopButton(
          context,
          busStop["code"],
          busStop["name"],
          busStop["mrt_stations"],
        ),

      // spacing at end of route
      Spacing(
        height: Values.marginBelowTitle,
      ),
    ];
    return Column(children: children).sliverToBoxAdapter();
  }

  Widget busStopButton(context, String code, String name, List mrtStations) {
    return Container(
      margin: EdgeInsets.only(top: Values.marginBelowTitle),
      child: InkWell(
          borderRadius: BorderRadius.circular(Values.borderRadius),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Values.busStopTileHorizontalPadding,
              vertical: Values.busStopTileVerticalPadding,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Values.borderRadius),
                color: TileColors.busServiceTile(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(name),
                    MRTStations(stations: mrtStations),
                  ],
                ),
                Text(code, style: Theme.of(context).textTheme.display2,),
              ],
            ),
          ),
          onTap: () => Routing.openRoute(context, StopOverviewPage(code: code))),
    );
  }
}
