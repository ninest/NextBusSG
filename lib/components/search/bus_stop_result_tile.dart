import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextbussg/components/core/mrt_stations.dart';
import 'package:nextbussg/components/search/stop_page/stop_overview_page.dart';
import 'package:nextbussg/styles/tile_color.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/route.dart';

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
    return Container(
      margin: EdgeInsets.only(top: Values.marginBelowTitle),
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Values.busStopTileHorizontalPadding,
            vertical: Values.busStopTileVerticalPadding,
          ),
          child: Row(
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
                      maxLines: 3,
                      style: Theme.of(context).textTheme.display1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (mrtStations.isNotEmpty)
                    MRTStations(stations: mrtStations)
                ],
              ),
              Expanded(
                flex: 0,
                child: Text(code, style: Theme.of(context).textTheme.display2),
              ),
            ],
          ),
        ),
        borderRadius: BorderRadius.circular(Values.borderRadius),
        onTap: () => Routing.openRoute(context, StopOverviewPage(code: code)),
      ),
      decoration: BoxDecoration(
        color: TileColors.busServiceTile(context),
        borderRadius: BorderRadius.circular(Values.borderRadius),
      ),
    );

    // ListTile seems to have the padding I want without me setting it ...
  }
}
