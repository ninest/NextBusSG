import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:nextbussg/models/bus_stop.dart';
import 'package:nextbussg/services/bus.dart';

class SearchProvider extends ChangeNotifier {
  List _searchResults = [];
  List getSearchResults() => _searchResults;

  bool _noStopsFound = false;
  bool getNoStopsFoundValue() => _noStopsFound;

  getNearestBusStopSearchResults() async {
    _searchResults = await BusService.getNearestStops();
    notifyListeners();
  }

  searchFor(String query) async {
    print("Query rec: $query");

    List allBusStops = await BusService.getAllStops();
    List<BusStop> searchResults = [];

    // make sure query is not empty
    if (query.isNotEmpty) {
      for (BusStop bs in allBusStops) {
        if (bs.name.toLowerCase().contains(query) || bs.code.contains(query)) {
          searchResults.add(bs);
        }
      }
      if (searchResults.isNotEmpty) {
        try {
          _searchResults =
              searchResults.sublist(0, 50); // for better performance
        } catch (e) {
          _searchResults = searchResults;
        }
        _noStopsFound = false;
        notifyListeners();
      } else {
        // no results for query
        BotToast.showText(text: "No results found.", contentColor: Colors.red);
      }
    } else {
      // if empty, just display stops nearby
      print('getting nearest stops');
      _searchResults = await BusService.getNearestStops();
      notifyListeners();
    }
  }

  // searchFor(String text) async {
  //   // if the string is empty or null, search results should just display the nearest bus stops (and buses)
  //   print("searchFor: $text");
  //   if (text == "" || text == null) {
  //     print("No query, giving nearest bus stops");
  //     _searchResults = await BusService.getNearestStops();
  //     notifyListeners();
  //   } else {
  //     print("Search query: $text");
  //     List allBusStops = await BusService.getAllStops();
  //     List<BusStop> searchResults = [];
  //     // TODO: implement search
  //     for (BusStop bs in allBusStops) {
  //       // check if any of the search terms are in the bus stop name or number
  //       if (bs.name.contains(text) || bs.code.contains(text)) {
  //         searchResults.add(bs);
  //       }
  //     }
  //     _searchResults = searchResults;
  //     notifyListeners();
  //   }
  // }
}
