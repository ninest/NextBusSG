import 'package:nextbussg/components/home/timings_not_available.dart';
import 'package:nextbussg/styles/border_color.dart';
import 'package:styled_widget/styled_widget.dart';
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

  List<BusArrival> busArrivalList;
  List<String> timingsNotAvailable;

  @override
  Widget build(BuildContext context) {
    List<Widget> busServiceTileList = [];

    for (var service in widget.services) {
      BusArrival ba;
      try {
        ba = busArrivalList.firstWhere((b) => b.service == service);
        busServiceTileList.add(BusServiceTile(
            code: widget.code, service: service, busArrival: ba));
      } catch (e) {
        // make sure we don't add doubles
        if (!timingsNotAvailable.contains(service))
          timingsNotAvailable.add(service);
      }
    }

    return ExpansionTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.name, style: Theme.of(context).textTheme.display1),

          // TODO: display mrt station here
          // because of height issues, we'll do it later
          // if (!(widget.mrtStations == null))
          //   MRTStations(stations: widget.mrtStations)
        ],
      ),
      // the text below is replacing the default arrow in ExpansionPanel
      trailing: Text(widget.code, style: Theme.of(context).textTheme.display2),

      // get bus timings only when panel has been opened
      onExpansionChanged: (bool value) => value ? _getBusTimings() : null,
      initiallyExpanded: widget.initialyExpanded,
      children: [
        ...busServiceTileList,

        // show that some timings are not available
        // NOTE: it also could just be that timings are unailable,
        if (timingsNotAvailable.isNotEmpty)
          // Text(timingsNotAvailable.toString())
          TimingsNotAvailable(services: timingsNotAvailable)
      ],
    )
        // .padding(top: 10)
        .border(
          all: 3,
          // check if dank mode
          color: BorderColors.busStopExpansionPanel(context),
          style: BorderStyle.solid,
        )
        .borderRadius(all: Values.borderRadius)
        .padding(top: Values.marginBelowTitle)
        // .height(0)
        .gestures();
    // margin(top: Values.marginBelowTitle)
  }

  _getBusTimings() async {
    // reset services not in opertion:
    timingsNotAvailable = [];

    // this function also populates the variable "servicesNotInOperation"
    List<BusArrival> newList = await BusService.getBusTimings(widget.code);

    setState(() {
      // the var servicesNotInOperation is not mentioned here because it is not required (? need better explanation ...)
      busArrivalList = newList;
    });
  }

  _addToFavorites() {
    // show bottom sheet
    print("Showing bottom sheets");
  }
}
