import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/home/bus_stop_list.dart';
import 'package:nextbussg/components/home/favorites/favorites_list.dart';
import 'package:nextbussg/services/provider/favorites.dart';
import 'package:nextbussg/widgets/page_template.dart';
import 'package:nextbussg/widgets/space.dart';

class HomePage extends StatelessWidget {
  // if there are no favorites (in simlified favorites view), the favorites heading should come below near me
  // if there are in SFV, put favorites at the top
  Future order(BuildContext context) async {
    Widget nearMe =
        BusStopList(title: 'NEAR ME', iconData: FontAwesomeIcons.locationArrow);
    Widget favoritesComponent({int favoritesNotShown=0}) => FavoritesBusStopList(
        title: 'FAVORITES', iconData: FontAwesomeIcons.heart, simplified: true, favoritesNotShown: favoritesNotShown);
    List<Widget> widgetOrder = [
      favoritesComponent(),
      Spacing(height: 40).sliver(),
      nearMe
    ];

    // if there are no favorites, swap the position of favorites and near me
    List favorites = await FavoritesProvider.getFavorites(simplified: true);
    if (favorites.isEmpty) {
      // even if the SF list is empty, there may be bus stops which are not near us. That's why 
      // we check if the list is empty, then check the ACTUAL amount of favorites
      // if it's more than 0, it means that it's not showing

      // so just to make it clear to the user, display a message:
      // You have 3 favorites, which are not near you.

      var noFavorites = (await FavoritesProvider.getFavorites(simplified: false)).length;
      widgetOrder = [nearMe, Spacing(height: 40).sliver(), favoritesComponent(favoritesNotShown: noFavorites)];
    }

    return widgetOrder;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: order(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return PageTemplate(
          children: [
            if (!snapshot.hasData)
              SliverToBoxAdapter(child: Text("Loading"))
            else
              ...snapshot.data
          ],
        );
      },
    );
  }
}
