import 'package:flutter/material.dart';
import 'package:nextbussg/styles/border_color.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:styled_widget/styled_widget.dart';

class LoadingBusStopTile extends StatelessWidget {
  final int count;
  LoadingBusStopTile({this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (var i = 1; i <= count; i++) buildSingleTile(context)
      ],
    );
  }

  Widget buildSingleTile(BuildContext context) => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 100,
              height: Theme.of(context).textTheme.display1.fontSize,
              child: Container()
                  .backgroundColor(Theme.of(context).textTheme.display1.color),
            ).borderRadius(all: Values.borderRadius * 0.8),
            SizedBox(
              width: 40,
              height: Theme.of(context).textTheme.display2.fontSize,
              child: Container()
                  .backgroundColor(Theme.of(context).textTheme.display2.color),
            ).borderRadius(all: Values.borderRadius * 0.8)
          ],
        )
            .padding(
              // these values have been hard-coded
              horizontal: Values.busStopTileHorizontalPadding,
              vertical: Values
                  .busStopTileVerticalPadding, // <- this value looks fine when em=19, but looks weird for other sizes
            )
            .opacity(0.6),
      )
          .border(
            all: 3,
            color: BorderColors.busStopExpansionPanel(context),
            style: BorderStyle.solid,
          )
          .borderRadius(all: Values.borderRadius)
          .padding(top: Values.marginBelowTitle);
}
