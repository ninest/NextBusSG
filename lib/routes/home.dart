import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/core/loading/finding_location.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/components/home/bus_stop_list.dart';
import 'package:nextbussg/components/home/favorites/favorites_list.dart';
import 'package:nextbussg/providers/favorites.dart';
import 'package:nextbussg/providers/home_rebuilder.dart';
import 'package:nextbussg/providers/location_perms.dart';
import 'package:nextbussg/routes/permission.dart';
import 'package:nextbussg/utils/strings.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getHomeWidgets(context),
      builder: (context, snapshot) {
        return PageTemplate(
          children: [
            if (snapshot.hasData)
              ...snapshot.data
            else
              Center(child: Text("Loading no data...")).sliverToBoxAdapter()
          ],
        ).scaffold();
      },
    );
  }

  Future<List<Widget>> getHomeWidgets(context) async {
    Widget nearMe = BusStopList(
      title: Strings.nearMeTitle.toUpperCase(),
      iconData: FontAwesomeIcons.locationArrow,
    );

    // if there are no favorites (in simlified favorites view), the favorites heading should come below near me
    // if there are in SFV, put favorites at the top

    List<Widget> widgetOrder = [
      simplifiedFavoritesView(),
      Spacing(height: 40).sliver(),
      nearMe,
    ];

    // if there are no favorites, swap the position of favorites and near me
    List favorites = await FavoritesProvider.getFavorites(context, simplified: true);
    if (favorites.isEmpty) {
      // even if the SF list is empty, there may be bus stops which are not near us. That's why
      // we check if the list is empty, then check the ACTUAL amount of favorites
      // if it's more than 0, it means that it's not showing

      // so just to make it clear to the user, display a message:
      // You have 3 favorites, which are not near you.

      var noFavorites = (await FavoritesProvider.getFavorites(context, simplified: false)).length;
      widgetOrder = [
        nearMe,
        Spacing(height: 40).sliver(),
        simplifiedFavoritesView(favoritesNotShown: noFavorites)
      ];
    }
    return widgetOrder;
  }

  Widget simplifiedFavoritesView({int favoritesNotShown = 0}) => FavoritesBusStopList(
        title: Strings.simplifiedFavoritesTitle.toUpperCase(),
        iconData: FontAwesomeIcons.heart,
        simplified: true,
        favoritesNotShown: favoritesNotShown,
      );
}
