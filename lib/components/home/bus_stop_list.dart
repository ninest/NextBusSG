import 'package:flutter/material.dart';
import 'package:nextbussg/components/core/loading/circular_spinner.dart';
import 'package:nextbussg/components/search/stop_page/stop_overview_page.dart';
import 'package:nextbussg/utils/route.dart';
import 'package:nextbussg/utils/strings.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:nextbussg/components/home/bus_stop_expansion_tile.dart';
import 'package:nextbussg/components/core/title_text.dart';
import 'package:nextbussg/services/bus.dart';

class BusStopList extends StatelessWidget {
  final String title;
  final IconData iconData;

  /*
  This widget is used for NEAR ME and all the favorites
  on the main page, we can see NEAR ME and a simplified favorites view.
    - simplified favorites view only shows the favorites buses in under their bus stops
      if the user is near that bus stop

  all favorites are only shown on the tap of a button
  */

  // 'near' and 'favorites'
  BusStopList({this.title, this.iconData});

  @override
  Widget build(BuildContext context) {
    // only require widget rebuilding for favorites for the favorites list
    // required to add/remove bus services

    return FutureBuilder(
      // get stops near me or favorites (change to enum?)
      future: BusService.getNearestStops(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Widget> children = <Widget>[
          if (snapshot.hasData)
            if (snapshot.data.isNotEmpty)
              for (var busStop in snapshot.data)
                BusStopExpansionPanel(
                  name: busStop.name,
                  code: busStop.code,
                  services: busStop.services,
                  initialyExpanded: false,
                  mrtStations: busStop.mrtStations,
                )
            else
              // no stops near me
              Text(
                Strings.noStopsNearby,
                style: Theme.of(context).textTheme.body1.copyWith(color: Colors.red),
              )
          else
            // placeholder widgets while stops are loding
            CircularSpinner()
        ];

        // TODO: find a way to put a slight animation
        // so users can see each bus stop being "added" nicely
        // heading (near me/favorites)

        // bus stop tile list
        // column needed because otherwise widgets dissapear before being scrolled awau

        return Column(
          children: [
            TitleText(
              title: title,
              iconData: iconData,
            ),
            ...children,
          ],
        ).sliverToBoxAdapter();
      },
    );
    // }
  }
  // each tile has a top margin (15)
}
