import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextbussg/components/core/mrt_stations.dart';
import 'package:nextbussg/components/search/stop_page/stop_overview_page.dart';
import 'package:nextbussg/styles/border_color.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/route.dart';
import 'package:styled_widget/styled_widget.dart';

class BusStopSearchResultTile extends StatelessWidget {
  final String code;
  final String name;
  final String road;
  final Position position;
  final List services;
  final List mrtStations;

  BusStopSearchResultTile({
    this.code,
    this.name,
    this.road,
    this.position,
    this.services,
    this.mrtStations,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // make sure not to get the overflow error
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.display1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (mrtStations.isNotEmpty)
                  MRTStations(stations: mrtStations)
              ],
            ),
            Text(code, style: Theme.of(context).textTheme.display2),
          ],
        )
            .padding(
              horizontal: Values.busStopTileHorizontalPadding,
              vertical: Values.busStopTileVerticalPadding,
            )
            .gestures(
              onTapDown: (details) => Routing.openRoute(context, StopOverviewPage(code: code)),
            ),
      ],
    )
        .border(
          all: 3,
          color: BorderColors.busStopExpansionPanel(context),
          style: BorderStyle.solid,
        )
        .borderRadius(all: Values.borderRadius)
        .padding(top: Values.marginBelowTitle);

    // ListTile seems to have the padding I want without me setting it ...
  }
}
