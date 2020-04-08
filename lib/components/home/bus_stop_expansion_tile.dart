import 'package:auto_route/auto_route.dart';
import 'package:nextbussg/components/home/timings_not_available.dart';
import 'package:nextbussg/components/core/mrt_stations.dart';
import 'package:nextbussg/components/search/stop_page/stop_overview_page.dart';
import 'package:nextbussg/router.gr.dart';
import 'package:nextbussg/services/renameFavorites.dart';
import 'package:nextbussg/styles/tile_color.dart';
import 'package:nextbussg/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:nextbussg/components/home/bus_service_tile.dart';
import 'package:nextbussg/models/bus_arrival.dart';
import 'package:nextbussg/services/bus.dart';
import 'package:nextbussg/styles/values.dart';

class BusStopExpansionPanel extends StatefulWidget {
  final String name;
  final String code;
  final List services;
  final bool initialyExpanded;
  final List mrtStations;
  BusStopExpansionPanel({
    this.name,
    this.code,
    this.services,
    this.initialyExpanded,
    this.mrtStations,
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
    if (widget.initialyExpanded) _getBusTimings();
  }

  @override
  void deactivate() {
    super.deactivate();
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

    // Color _backgroundColor = Theme.of(context).brightness == Brightness.light
    //     ? Colors.transparent.withOpacity(0.05)
    //     : Colors.transparent.withOpacity(0.5);

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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // if the stop HAS been renamed, display in italics
              Text(name,
                  style: hasBeenRenamed
                      ? Theme.of(context).textTheme.display1.copyWith(
                            fontStyle: FontStyle.italic,
                          )
                      : Theme.of(context).textTheme.display1),

              if (widget.mrtStations.isNotEmpty)
                MRTStations(stations: widget.mrtStations)
            ],
          ),
          // the text below is replacing the default arrow in ExpansionPanel
          // when it's clicked, open bus stop
          trailing: GestureDetector(
              child: Text(widget.code, style: Theme.of(context).textTheme.display2),
              onTap: () => _openStopOverviewPage()),
          // get bus timings only when panel has been opened
          onExpansionChanged: (bool value) {
            return value ? _getBusTimings() : null;
          },
          initiallyExpanded: widget.initialyExpanded,
          children: [
            ...busServiceTileList,

            // show that some timings are not available
            // NOTE: it also could just be that timings are unailable,
            if (timingsNotAvailable.isNotEmpty)
              // Text(timingsNotAvailable.toString())
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

  _getBusTimings() async {
    // reset services not in opertion:
    timingsNotAvailable = [];

    // this function also populates the variable "servicesNotInOperation"
    List<BusArrival> newList = await BusService.getBusTimings(widget.code);

    // make sure widget not siposed before calling setstate
    if (mounted)
      setState(() {
        // the var servicesNotInOperation is not mentioned here because it is not required (? need better explanation ...)
        busArrivalList = newList;
      });
  }

  _openStopOverviewPage() {
    // Routing.openRoute(
    //   context,
    //   StopOverviewPage(
    //     code: widget.code,
    //   ),
    // );
    ExtendedNavigator.ofRouter<Router>().pushNamed(Routes.searchPage);
  }
}
