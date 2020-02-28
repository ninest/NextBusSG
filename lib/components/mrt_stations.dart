import 'package:flutter/material.dart';
import 'package:nextbussg/styles/transit_colors.dart';
import 'package:styled_widget/styled_widget.dart';

class MRTStations extends StatelessWidget {
  final List stations;
  MRTStations({this.stations});

  // for some stations such as jurong, repeat refs are being shown
  // because LTG hasn't updated all the sites with new data
  // https://github.com/themindstorm/singapore-bus

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (stations.isNotEmpty) {
      Map stationsMap = stations.asMap();
      for (var index in stationsMap.keys) {

        for (var code in stationsMap[index]) {
          // the line ID is always the first two characters of the station ref
          // ex: ew, or ns
          String lineID = code.substring(0, 2);

          // getting the appropriate mrt line color
          Color color = TransitColors.mrtLineColors[lineID];

          children.add(
            Text(
              code.toUpperCase(),
              style: Theme.of(context).textTheme.display3,
            )
                .bold()
                .textColor(Colors.white70)
                .padding(all: 3)
                .backgroundColor(color)
                .borderRadius(all: 5)
                .padding(right: 3),
          );
        }
      }
    }

    return Row(
      children: [...children],
    ).padding(top: 9);
  }
}
