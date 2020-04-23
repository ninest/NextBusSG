import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nextbussg/components/more/rename_favorites/bottom_sheets.dart';
import 'package:nextbussg/components/core/mrt_stations.dart';
import 'package:nextbussg/providers/home_rebuilder.dart';
import 'package:nextbussg/services/bus.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:nextbussg/components/core/buttons/button.dart';
import 'package:nextbussg/components/home/bus_stop_expansion_tile.dart';
import 'package:nextbussg/components/search/stop_page/stop_servies_overview.dart';
import 'package:nextbussg/components/core/title_text.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/url.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:provider/provider.dart';

class StopOverviewPage extends StatelessWidget {
  final String code;
  StopOverviewPage({this.code});

  @override
  Widget build(BuildContext context) {
    // here just to rebuil page on stop rename
    final HomeRebuilderProvider homeRebuilderProvider =
        Provider.of<HomeRebuilderProvider>(context, listen: true);

    return Scaffold(
      body: FutureBuilder(
        future: _getStopData(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String name = snapshot.data['name'];
            String road = snapshot.data['road'];
            List services = snapshot.data['services'];
            List mrtStations = snapshot.data['mrt_stations'];
            double lat = snapshot.data['coords']['lat'];
            double lon = snapshot.data['coords']['lon'];

            return PageTemplate(
              showBackButton: true,
              children: [
                // name of bus stop
                TitleText(
                  title: name,
                ).sliverToBoxAdapter(),

                Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  // road and stop code
                  Text("$road – $code"),

                  if (mrtStations.isNotEmpty) ...[
                    Spacing(height: Values.marginBelowTitle),
                    MRTStations(
                      stations: mrtStations,
                    ),
                  ],

                  Spacing(height: Values.marginBelowTitle * 1.5),

                  // // showing all services
                  StopServicesOverview(
                    services: services,
                  ),
                  // // Text('mrt stations').sliverToBoxAdapter(),

                  Spacing(height: Values.marginBelowTitle * 1.5),

                  // // timings panel
                  // Text("Bus arrival timings:"),
                  BusStopExpansionPanel(
                    name: name,
                    code: code,
                    services: services,
                    initialyExpanded: false,

                    // don't show mrt stations even if there are a view, because they're shown above
                    mrtStations: [],

                    // tapping on the ID should NOT OPEN a new version of the same page
                    opensStopOverviewPage: false,
                  ),

                  Spacing(height: Values.marginBelowTitle * 2),

                  // // button to allow rename
                  Button(
                    text: "Rename",
                    // iconData: FontAwesomeIcons.directions,
                    // onTap: () => RenameFavoritesService.rename(context, code, newName),
                    onTap: () => RenameFavoritesBottomSheets.bs(context, code, name),
                  ),

                  Spacing(height: Values.marginBelowTitle),

                  // // showing directions
                  Button(
                    text: "Directions to bus stop",
                    fill: true,
                    // iconData: FontAwesomeIcons.directions,
                    onTap: () => _openMap(lon, lat),
                  )
                ]).sliverToBoxAdapter()
              ],
            );
          } else {
            return Text('Loading');
          }
        },
      ),
    );
  }

  _getStopData(context) async {
    // String jsonString = await rootBundle.loadString('assets/bus_stops.json');
    // Map stopData = json.decode(jsonString)[code];
    Map stopData =
        (await Provider.of<BusServiceProvider>(context, listen: false).getAllStopsMap())[code];

    // print(stopData);
    return stopData;
  }

  _openMap(lon, lat) {
    String url;
    if (Platform.isIOS)
      url = 'https://maps.apple.com/?q=$lat,$lon';
    else
      url = 'https://www.google.com/maps?q=$lat,$lon';
    openUrl(url);
  }
}
