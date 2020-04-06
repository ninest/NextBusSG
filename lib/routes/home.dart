import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/core/loading/finding_location.dart';
import 'package:nextbussg/components/core/location_access_button.dart';
// import 'package:nextbussg/components/core/location_access_button.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/components/core/title_text.dart';
import 'package:nextbussg/components/home/bus_stop_list.dart';
import 'package:nextbussg/components/home/favorites/all_favorites_page.dart';
import 'package:nextbussg/components/home/favorites/favorites_list.dart';
import 'package:nextbussg/components/more/mrt_map_page.dart';
import 'package:nextbussg/providers/favorites.dart';
import 'package:nextbussg/providers/home_rebuilder.dart';
import 'package:nextbussg/providers/locationPerms.dart';
import 'package:nextbussg/routes/search.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:nextbussg/utils/route.dart';
import 'package:nextbussg/utils/strings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';

class HomePage extends StatelessWidget {
  List<Widget> noLocationAccess(context) {
    final LocationPermissionsProvider locationPermissionsProvider =
        Provider.of<LocationPermissionsProvider>(context, listen: false);

    return [
      TitleText(
        title: "One more step ...",
      ).sliverToBoxAdapter(),
      Spacing(height: Values.marginBelowTitle).sliver(),
      Text("We require your location to find all the bus stops near you!").sliverToBoxAdapter(),
      Spacing(height: Values.marginBelowTitle).sliver(),
      LocationAccessButton().sliverToBoxAdapter(),
      Spacing(height: Values.marginBelowTitle).sliver(),
      if (locationPermissionsProvider.permDenied) ...[
        Text(Strings.locationPermissionDenied).sliverToBoxAdapter(),
        Spacing(height: Values.marginBelowTitle).sliver(),
        OpenLocationSettingsButton().sliverToBoxAdapter(),
        Spacing(height: Values.marginBelowTitle).sliver(),
        Text(Strings.afterEnablePermision).sliverToBoxAdapter(),
      ]
    ];
  }

  Widget yesLocationAccess(context) => FutureBuilder(
        future: order(context),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return PageTemplate(children: snapshot.data);
          else
            return FindingLocation();
        },
      );

  @override
  Widget build(BuildContext context) {

    final LocationPermissionsProvider locationPermissionsProvider =
        Provider.of<LocationPermissionsProvider>(context, listen: true);

    // this is just to rebuild the home page when a favorite is added/removed
    final HomeRebuilderProvider homeRebuilderProvider =
        Provider.of<HomeRebuilderProvider>(context, listen: true);

    print("Home widget rebuilt.");

    return FutureBuilder(
      future: locationPermissionsProvider.getBoolPermissionStatus,
      builder: (context, snapshot) {
        if (snapshot.hasData) if (snapshot.data == true)
          return yesLocationAccess(context);
        else
          return PageTemplate(children: noLocationAccess(context));
        else
          return Text("Loading");
      },
    );
  }

  Widget simplifiedFavoritesView({int favoritesNotShown = 0}) => FavoritesBusStopList(
        title: Strings.simplifiedFavoritesTitle.toUpperCase(),
        iconData: FontAwesomeIcons.heart,
        simplified: true,
        favoritesNotShown: favoritesNotShown,
      );

  Future order(context) async {
    Widget nearMe = BusStopList(
        title: Strings.nearMeTitle.toUpperCase(), iconData: FontAwesomeIcons.locationArrow);

    // if there are no favorites (in simlified favorites view), the favorites heading should come below near me
    // if there are in SFV, put favorites at the top

    List<Widget> widgetOrder = [simplifiedFavoritesView(), Spacing(height: 40).sliver(), nearMe];

    // if there are no favorites, swap the position of favorites and near me
    List favorites = await FavoritesProvider.getFavorites(simplified: true);
    if (favorites.isEmpty) {
      // even if the SF list is empty, there may be bus stops which are not near us. That's why
      // we check if the list is empty, then check the ACTUAL amount of favorites
      // if it's more than 0, it means that it's not showing

      // so just to make it clear to the user, display a message:
      // You have 3 favorites, which are not near you.

      var noFavorites = (await FavoritesProvider.getFavorites(simplified: false)).length;
      widgetOrder = [
        nearMe,
        Spacing(height: 40).sliver(),
        simplifiedFavoritesView(favoritesNotShown: noFavorites)
      ];
    }
    return widgetOrder;
  }
}
