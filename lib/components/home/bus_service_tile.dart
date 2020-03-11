import 'package:nextbussg/components/home/favorites/confirmation_bottom_sheet.dart';
import 'package:nextbussg/styles/border_color.dart';
import 'package:nextbussg/styles/transit_colors.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter/material.dart';
import 'package:nextbussg/models/bus_arrival.dart';

class BusServiceTile extends StatelessWidget {
  final String code;
  final String service;
  final BusArrival busArrival;
  BusServiceTile({this.code, this.service, this.busArrival});

  @override
  Widget build(BuildContext context) {
    // the load can be SEA, SDA, or LSD (green, orange, red)
    Map loadColors = {
      "SEA": TransitColors.seats,
      "SDA": TransitColors.standing,
      "LSD": TransitColors.limited,
    };

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Text(
              service,
              style: Theme.of(context).textTheme.display3,
            ),
          ),
          Flexible(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                for (var nextBus in busArrival.nextBuses)
                  Text(
                    nextBus.timeInMinutes ?? '-',
                    style: Theme.of(context).textTheme.display4.copyWith(
                          color: loadColors[nextBus.load],
                        ),
                  )
              ],
            ),
          )
        ],
      ).padding(
        all: Values.busServiceTilePadding,
        bottom: 0,
      ),
    )
        // .backgroundColor(Theme.of(context).primaryColor)
        .border(
          // all: 2,
          // bottom: 2,
          top: 1,
          color: BorderColors.busServiceTile(context),
          style: BorderStyle.solid,
        )
        // .borderRadius(all: Values.borderRadius * 0.8)

        // margin
        .padding(bottom: 18, horizontal: 18)
        .gestures(
            onTap: () {},
            onLongPress: () {
              // favoritesProvider.addToFavorite(code, service);
              ConfirmationBottomSheets.confirmAction(context, code, service);
            },
            onDoubleTap: () {
              // favoritesProvider.addToFavorite(code, service);
              ConfirmationBottomSheets.confirmAction(context, code, service);
            });
  }
}
