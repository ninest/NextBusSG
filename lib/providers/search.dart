import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:nextbussg/models/bus_stop.dart';
import 'package:nextbussg/services/bus.dart';
import 'package:provider/provider.dart';

class SearchProvider extends ChangeNotifier {
  List _searchResults = [];
  List getSearchResults() => _searchResults;

  bool _noStopsFound = false;
  bool getNoStopsFoundValue() => _noStopsFound;
  set noStopsFound(bool value) => _noStopsFound = value;

  searchFor(context, String query) async {
    print("Query rec: $query");

    final BusServiceProvider busServiceProvider =
        Provider.of<BusServiceProvider>(context, listen: false);
    Map allBusStopsMap = await busServiceProvider.getAllStopsMap();

    // can reuse this, add it ti busServiceProvider
    List allBusStops = [];
    for (var stopCode in allBusStopsMap.keys) {
      BusStop busStop = BusStop.fromJson(allBusStopsMap[stopCode]);
      allBusStops.add(busStop);
    }

    List<BusStop> searchResults = [];

    // make sure query is not empty
    if (query.isNotEmpty) {
      for (BusStop bs in allBusStops) {
        if (bs.name.toLowerCase().contains(query.toLowerCase()) ||
            bs.road.contains(query.toLowerCase()) ||
            bs.code.contains(query)) {
          searchResults.add(bs);
        }

        // also check if mrt station searched
        if (bs.mrtStations.isNotEmpty)
          for (List stationList in bs.mrtStations) {
            // changing query to upper case because all mrt station refs are upper case
            if (stationList.contains(query.toUpperCase())) searchResults.add(bs);
          }
      }
      if (searchResults.isNotEmpty) {
        try {
          _searchResults = searchResults.sublist(0, 50); // for better performance
        } catch (e) {
          _searchResults = searchResults;
        }
        _noStopsFound = false;
        notifyListeners();
      } else {
        // no results for query
        BotToast.showText(text: "No results found.", contentColor: Colors.red);

        _noStopsFound = true;
        notifyListeners();
      }
    } else {
      // if empty, just display stops nearby
      print('Search results empty');
      _searchResults = [];
      notifyListeners();
    }
  }
}
