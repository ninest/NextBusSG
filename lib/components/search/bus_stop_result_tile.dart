import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextbussg/components/mrt_stations.dart';
import 'package:nextbussg/styles/border_color.dart';
import 'package:nextbussg/styles/values.dart';
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
                Text(name, style: Theme.of(context).textTheme.display1),
                if (!(mrtStations == null)) MRTStations(stations: mrtStations)
              ],
            ),
            Text(code, style: Theme.of(context).textTheme.display2),
          ],
        ).padding(
          horizontal: Values.busStopTileHorizontalPadding,
          vertical: Values.busStopTileVerticalPadding,
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
