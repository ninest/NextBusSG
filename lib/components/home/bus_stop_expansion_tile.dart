import 'package:geolocator/geolocator.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/components/home/timings_not_available.dart';
import 'package:nextbussg/components/core/mrt_stations.dart';
import 'package:nextbussg/components/search/stop_page/stop_overview_page.dart';
import 'package:nextbussg/services/rename_favorites.dart';
import 'package:nextbussg/styles/tile_color.dart';
import 'package:nextbussg/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:nextbussg/components/home/bus_service_tile.dart';
import 'package:nextbussg/models/bus_arrival.dart';
import 'package:nextbussg/services/bus.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:provider/provider.dart';

class BusStopExpansionPanel extends StatefulWidget {
  final String name;
  final String code;
  final List services;
  final bool initialyExpanded;
  final List mrtStations;
  final Position position;

  // of this is false, tapping on the id won't open the stop overpage
  final bool opensStopOverviewPage;

  BusStopExpansionPanel({
    this.name,
    this.code,
    this.services,
    this.initialyExpanded,
    this.mrtStations,
    this.position,
    this.opensStopOverviewPage = true,
  });

  @override
  _BusStopExpansionPanelState createState() => _BusStopExpansionPanelState();
}

class _BusStopExpansionPanelState extends State<BusStopExpansionPanel> {
  @override
  void initState() {
    super.initState();
    busArrivalList = [
      for (var service in widget.services)
        BusArrival(service: service, operatorName: null, nextBuses: [
          NextBus(timeInMinutes: null, load: null, feature: null, type: null),
          NextBus(timeInMinutes: null, load: null, feature: null, type: null),
          NextBus(timeInMinutes: null, load: null, feature: null, type: null),
        ])
    ];

    // reset the unavailable timings so it doesn't get filled with repeats
    timingsNotAvailable = [];

    // if we are in the simplified favorites, it means initiallyExpanded is true
    // in that case, automatically get bus timings
    if (widget.initialyExpanded) _getBusTimings(context);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<BusArrival> busArrivalList;
  List<String> timingsNotAvailable;

  @override
  Widget build(BuildContext context) {
    List<Widget> busServiceTileList = [];

    for (var service in widget.services) {
      // adding the placeholder for when it's expanded
      BusArrival ba;
      try {
        ba = busArrivalList.firstWhere((b) => b.service == service);
        busServiceTileList.add(BusServiceTile(code: widget.code, service: service, busArrival: ba));
      } catch (e) {
        // make sure we don't add doubles
        if (!timingsNotAvailable.contains(service)) timingsNotAvailable.add(service);
      }
    }

    // check if the user has renamed the favorite

    String name;
    bool hasBeenRenamed;
    if (RenameFavoritesService.getName(widget.code) == null) {
      // has not been renamed
      hasBeenRenamed = false;
      name = widget.name;
    } else {
      hasBeenRenamed = true;
      name = RenameFavoritesService.getName(widget.code);
    }

    return ListTileTheme(
      // setting padding value if mrt is there
      // THESE VALUES ARE HARDOCDED because I don't know how to really change them
      contentPadding: EdgeInsets.only(
        left: Values.busStopTileHorizontalPadding,
        right: Values.busStopTileHorizontalPadding,
        // top: 0,
        // bottom: 0
        top: widget.mrtStations.isNotEmpty ? Values.busStopTileVerticalPadding / 2 : 0,
        bottom: widget.mrtStations.isNotEmpty ? Values.busStopTileVerticalPadding / 2 : 0,
      ),
      child: Container(
        margin: EdgeInsets.only(top: Values.marginBelowTitle),
        child: ExpansionTile(
          title: _busStopName(context, name, hasBeenRenamed),
          // the text below is replacing the default arrow in ExpansionPanel
          // when it's clicked, open bus stop
          trailing:  _busStopCode(context),
          // trailing: Text(""),
          // trailing: Icon(
          //   FontAwesomeIcons.bus,
          //   size: Theme.of(context).textTheme.display2.fontSize,
          // ),

          // get bus timings only when panel has been opened
          onExpansionChanged: (bool value) {
            return value ? _getBusTimings(context) : null;
          },
          initiallyExpanded: widget.initialyExpanded,
          children: [
            ...busServiceTileList,

            // show that some timings are not available
            if (timingsNotAvailable.isNotEmpty)
              TimingsNotAvailable(services: timingsNotAvailable)
          ],
        ),
        decoration: BoxDecoration(
          color: TileColors.busStopExpansionTile(context),
          borderRadius: BorderRadius.circular(Values.borderRadius),
        ),
      ),
    );
    // margin(top: Values.marginBelowTitle)
  }

  InkWell _busStopCode(BuildContext context) {
    return InkWell(
      child: Container(
        // un comment below to see tap area
        // color: Colors.red,
        // extra padding so the user has a bigger area to top
        padding: EdgeInsets.only(top: 17.0, bottom: 17.0, left: 17.0),
        child: Text(widget.code, style: Theme.of(context).textTheme.display2),
      ),

      // if we're already on the stop overview page, this should just epand the widget
      // by setting to null, the inkwell has no effect, so tapping just expands the tile
      onTap: widget.opensStopOverviewPage ? () => _openStopOverviewPage() : null,
      // if the position is available, long pressing the ID will open in map
      // onLongPress: widget.position != null
      //     ? () => openMap(widget.position.longitude, widget.position.latitude)
      //     : () => {},
      // onDoubleTap: () => RenameFavoritesBottomSheets.bs(context, widget.code, widget.name),
    );
  }

  Column _busStopName(BuildContext context, String name, bool hasBeenRenamed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // if the stop HAS been renamed, display in italics
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: hasBeenRenamed
                  ? Theme.of(context).textTheme.display1.copyWith(
                        fontStyle: FontStyle.italic,
                      )
                  : Theme.of(context).textTheme.display1,
            ),
            Spacing(height: Values.marginBelowTitle / 2).side(),
            // Text(widget.code, style: Theme.of(context).textTheme.display2),
          ],
        ),

        Wrap(
          children: <Widget>[
            // Text(widget.code),
            if (widget.mrtStations.isNotEmpty)
              MRTStations(stations: widget.mrtStations)
          ],
        ),
      ],
    );
  }

  _getBusTimings(context) async {
    // reset services not in opertion:
    timingsNotAvailable = [];

    // this function also populates the variable "servicesNotInOperation"
    final BusServiceProvider busServiceProvider =
        Provider.of<BusServiceProvider>(context, listen: false);
    List<BusArrival> newList = await busServiceProvider.getBusTimings(widget.code);

    // make sure widget not siposed before calling setstate
    if (mounted)
      setState(() {
        // the var servicesNotInOperation is not mentioned here because it is not required (? need better explanation ...)
        busArrivalList = newList;
      });
  }

  _openStopOverviewPage() {
    // if we're already in the stop overview page, don't open it again
    if (widget.opensStopOverviewPage)
      Routing.openRoute(
        context,
        StopOverviewPage(
          code: widget.code,
        ),
      );
  }
}
