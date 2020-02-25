import 'package:nextbussg/components/home/confirmation/confirmation_bottom_sheet.dart';
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
                    style: Theme.of(context).textTheme.display4,
                  )
              ],
            ),
          )
        ],
      ).padding(all:Values.busServiceTilePadding),
    )
        // .backgroundColor(Theme.of(context).primaryColor)
        .border(
          all: 2,
          color: Colors.black45,
          style: BorderStyle.solid,
        )
        .borderRadius(all: Values.borderRadius * 0.8)

        // margin
        .padding(bottom: 18, horizontal: 18)
        .gestures(onTap: () {

        },
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
