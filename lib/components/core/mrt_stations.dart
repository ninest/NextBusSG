import 'package:flutter/material.dart';
import 'package:nextbussg/styles/transit_colors.dart';

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
          Color textColor = TransitColors.mrtLineColors[lineID];
          Color backgroundCcolor = TransitColors.mrtLineColors[lineID].withOpacity(0.3);

          // gettind index of code.
          // if it's the first one, don't put margin-left
          int ind = stationsMap[index].indexOf(code);

          children.add(
            Container(
              margin: ind > 0 ? EdgeInsets.only(left: 3.0) : null,
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(color: backgroundCcolor, borderRadius: BorderRadius.circular(5)),
              child: Text(
                code.toUpperCase(),
                style: Theme.of(context).textTheme.display3.copyWith(
                      fontWeight: FontWeight.bold,
                      // color: Colors.white70,
                      color: textColor,
                    ),
              ),
            ),
          );
        }
      }
    }

    return Padding(
      padding: EdgeInsets.only(top: 9),
      child: Row(
        children: [...children],
      ),
    );
  }
}
