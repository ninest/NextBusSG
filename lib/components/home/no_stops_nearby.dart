import 'package:flutter/material.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/strings.dart';

class NoStopsNearBy extends StatelessWidget {
  const NoStopsNearBy({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(
      //   bottom: Values.marginBelowTitle,
      //   left: Values.busServiceTilePadding,
      //   right: Values.busServiceTilePadding,
      // ),
      padding: EdgeInsets.all(Values.busServiceTilePadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Values.borderRadius * 0.8),
        color: Theme.of(context).errorColor.withOpacity(Values.containerOpacity),
      ),
      child: Text(
        Strings.noStopsNearby,
        style: Theme.of(context).textTheme.body1.copyWith(
              color: Theme.of(context).errorColor,
            ),
      ),
    );
  }
}
