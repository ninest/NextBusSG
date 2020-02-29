import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nextbussg/services/renameFavorites.dart';
import 'package:nextbussg/strings.dart';
import 'package:provider/provider.dart';
import 'package:nextbussg/components/buttons/button.dart';
import 'package:nextbussg/components/home/bus_service_tile.dart';
import 'package:nextbussg/components/home/favorites/all_favorites_page.dart';
import 'package:nextbussg/services/provider/favorites.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/widgets/page_template.dart';

import '../../title_text.dart';
import 'package:styled_widget/styled_widget.dart';

import '../bus_stop_expansion_tile.dart';

class FavoritesBusStopList extends StatelessWidget {
  final String title;
  final IconData iconData;
  final bool simplified;
  final int favoritesNotShown;
  // this is to show if there are favorites NOT showing in the SFV
  FavoritesBusStopList({this.title, this.iconData, this.simplified, this.favoritesNotShown});

  @override
  Widget build(BuildContext context) {
    // this needs to be there so that this widget will rebuild itself when a fav is added/removed
    FavoritesProvider favoritesProvider = Provider.of<FavoritesProvider>(context);

    return FutureBuilder(
      future: FavoritesProvider.getFavorites(simplified: simplified),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        String noFavoritesText = Strings.noFavorites;
        if (favoritesNotShown > 0) {
          // make sure not to pluralize if it's 1
          String pluralize = "s";
          // also change the verb if it's singular
          String verb = "are";
          if (favoritesNotShown == 1) {
            pluralize = "";
            verb = "is";
          }
          noFavoritesText +=
              "\n\nYou have **$favoritesNotShown** favorite$pluralize that $verb not being displayed as you are not near them.";
        }

        List<Widget> children = [
          if (!snapshot.hasData)
            Text("Loading")
          else if (snapshot.data.isEmpty)
            MarkdownBody(data: noFavoritesText)
          else
            for (var busStop in snapshot.data)
              BusStopExpansionPanel(
                name: busStop.name,
                code: busStop.code,
                services: busStop.services,
                mrtStations: busStop.mrtStations,

                // only show expanded tiles on the main page (SFV)
                // this way, the user an immediately see timings for fav bus service without clicking anywhere
                initialyExpanded: simplified ? true : false,
              )
        ];

        // if it's the simplified favorites, show button to see all favorites
        if (simplified)
          children.add(openCloseButton(
            "See all",
            Theme.of(context).primaryColor,
            () {
              print("Opening all favorites page");
              Navigator.push(context, MaterialPageRoute(builder: (context) => AllFavoritesPage()));
            },
          ));
        // when it's the all favorites page, the button should be for taking users back
        // to the main page
        else
          children.add(openCloseButton(
            "Close",
            Colors.red,
            () {
              print("Closing favorites page");
              Navigator.of(context).pop();
            },
          ));

        return SliverList(
          delegate: SliverChildListDelegate([
            TitleText(
              title: title,
              iconData: iconData,
            ).padding(bottom: 10),
            // bus stop tile list
            Column(children: children)
          ]),
        );
      },
    );
  }

  Widget openCloseButton(String text, Color color, Function onTap) => Button(
        text: text,
        color: color,
        onTap: () {
          onTap();
        },
      ).alignment(Alignment.topRight).padding(top: Values.marginBelowTitle * 1.5);
}
