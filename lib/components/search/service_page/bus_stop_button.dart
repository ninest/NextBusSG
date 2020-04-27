import 'package:flutter/material.dart';
import 'package:nextbussg/components/core/mrt_stations.dart';
import 'package:nextbussg/components/search/stop_page/stop_overview_page.dart';
import 'package:nextbussg/styles/tile_color.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/route.dart';

class BusStopButton extends StatelessWidget {
  const BusStopButton({@required this.code, @required this.name, @required this.mrtStations});
  final String code;
  final String name;
  final List mrtStations;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Values.marginBelowTitle / 2),
      child: InkWell(
        borderRadius: BorderRadius.circular(Values.borderRadius),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Values.busStopTileHorizontalPadding,
            vertical: Values.busStopTileVerticalPadding / 2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Values.borderRadius),
            color: TileColors.busServiceTile(context),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      // "namenamenamenamenamenamename",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (mrtStations.isNotEmpty) MRTStations(stations: mrtStations),
                  ],
                ),
              ),

              // The ID's should always be there
              Expanded(
                flex: 0,
                child: InkWell(
                  // onLongPress: () => openMap(lon, lat),
                  child: Text(
                    code,
                    style: Theme.of(context).textTheme.display2,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () => Routing.openRoute(context, StopOverviewPage(code: code)),
      ),
    );
  }
}
