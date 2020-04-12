import 'package:flutter/material.dart';
import 'package:nextbussg/styles/text_fields.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:provider/provider.dart';
import 'package:nextbussg/providers/search.dart';
import 'package:nextbussg/styles/values.dart';


class SearchTextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*
    (1) Change minor styling when search box focussed
    (2) When focussed, add buttons to
      - clear text
      - switch to number keyboard
     */

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Spacing(height: Values.marginBelowTitle),
          Expanded(
            flex: 5,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Type a bus or bus stop",
                filled: true,
                fillColor: TextFieldStyles.backgroundColor(context),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Values.borderRadius),
                  borderSide: BorderSide(
                    color: TextFieldStyles.backgroundColor(context),
                    width: 0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Values.borderRadius),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 4,
                    )),
              ),
              onChanged: (query) => _onQueryChanged(context, query),
            ),
          ),
          // TODO: add number keyboard and cross button
        ],
      ),
    );
  }

  _onQueryChanged(BuildContext context, String query) {
    final SearchProvider searchProvider = Provider.of<SearchProvider>(context, listen: false);
    if (query.isNotEmpty) {
      // only search if query not empty
      searchProvider.searchFor(context, query);
    } else {
      // if it is empty, just show the nearest stps
      print('query is empty');
      // searchProvider.getNearestBusStopSearchResults(context);
    }
  }
}
