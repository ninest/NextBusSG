import 'package:flutter/material.dart';
import 'package:nextbussg/components/core/loading/circular_spinner.dart';
import 'package:provider/provider.dart';
import 'package:nextbussg/components/search/bus_stop_result_tile.dart';
import 'package:nextbussg/providers/search.dart';

class SearchResultsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SearchProvider searchProvider = Provider.of<SearchProvider>(context);

    List searchResults = searchProvider.getSearchResults();

    // show nearest stops if no search term
    if (searchResults.isEmpty) searchProvider.getNearestBusStopSearchResults(context);

    return Column(
      children: <Widget>[
        if (searchResults.isEmpty) CircularSpinner(),
        for (var busStop in searchResults)
          // Text("A search result will come here.")
          BusStopSearchResultTile(
            name: busStop.name,
            code: busStop.code,
            mrtStations: busStop.mrtStations,
          ),
      ],
    );
  }
}
