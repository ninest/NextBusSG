import 'package:flutter/material.dart';
import 'package:nextbussg/components/home/loading/loading_bus_stop_tile.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:nextbussg/components/home/bus_stop_expansion_tile.dart';
import 'package:nextbussg/components/title_text.dart';
import 'package:nextbussg/services/bus.dart';

class BusStopList extends StatelessWidget {
  final String title;
  final IconData iconData;

  /*
  This widget is used for NEAR ME and all the favorites
  on the main page, we can see NEAR ME and a simplified favorites view.
    - simplified favorites view only shows the favorites buses in under their bus stops
      if the user is near that bus stop

  all favorites are only shown on the tap of a button
  */

  // 'near' and 'favorites'
  BusStopList({this.title, this.iconData});

  @override
  Widget build(BuildContext context) {
    // only require widget rebuilding for favorites for the favorites list
    // required to add/remove bus services

    return FutureBuilder(
      // get stops near me or favorites (change to enum?)
      future: BusService.getNearestStops(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Widget> children = <Widget>[
          if (snapshot.hasData)
            for (var busStop in snapshot.data)
              BusStopExpansionPanel(
                name: busStop.name,
                code: busStop.code,
                services: busStop.services,
                initialyExpanded: false,
                mrtStations: busStop.mrtStations,
              )
          else
            // placeholder widgets while stops are loding
            LoadingBusStopTile(
              count: 2,
            ),
        ];

        // TODO: find a way to put a slight animation
        // so users can see each bus stop being "added" nicely

        return SliverList(
          delegate: SliverChildListDelegate([
            // heading (near me/favorites)
            TitleText(
              title: title,
              iconData: iconData,
            ).padding(bottom: 10),
            // bus stop tile list
            Column(children: children)
          ]),
        );
      },
    );
    // }
  }
  // each tile has a top margin (15)
}
