import 'package:flutter/material.dart';
import 'package:nextbussg/styles/tile_color.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/constants/strings.dart';

class LoadingText extends StatelessWidget {
  final String text;
  LoadingText({this.text = "Loading ..."});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Values.busStopTileHorizontalPadding,
        vertical: Values.busStopTileVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: TileColors.busStopExpansionTile(context),
        borderRadius: BorderRadius.circular(Values.borderRadius),
      ),
      child: Column(
        // shrinkWrap: true,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: Theme.of(context).textTheme.title.copyWith(
                  fontSize: Values.em * 1.1,
                  fontWeight: FontWeight.w500,
                ),
          ),
          Text(
            _getRandomMessage(),
            style: Theme.of(context).textTheme.body1.copyWith(
                  fontSize: Values.em * 0.8,
                ),
          ),
        ],
      ),
    );
  }

  _getRandomMessage() {
    // get a random message from the messages array
    return (Strings.messages.toList()..shuffle()).first;
  }
}
