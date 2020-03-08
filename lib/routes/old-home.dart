import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/core/location_access_button.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/components/home/bus_stop_list.dart';
import 'package:nextbussg/components/home/favorites/favorites_list.dart';
import 'package:nextbussg/providers/favorites.dart';
import 'package:nextbussg/utils/location_perms.dart';
import 'package:nextbussg/utils/strings.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  // if there are no favorites (in simlified favorites view), the favorites heading should come below near me
  // if there are in SFV, put favorites at the top
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PermissionStatus _status;
  List<Widget> _widgetOrder = [];

  @override
  void initState() {
    super.initState();
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationWhenInUse)
        .then(_updateStatus);
  }

  void _updateStatus(PermissionStatus status) {
    print("Current permission status: $status");

    if (status != PermissionStatus.granted) {
      print('not granted or unknown');
      setState(() {
        _widgetOrder = [Text("You have not granted permission, or it's unknown")];
      });
    }

    if (status == PermissionStatus.granted) {
      print("Granted");
      setState(() {
        _widgetOrder = [Text("You have granted permission")];
        // Widget nearMe = BusStopList(title: 'NEAR ME', iconData: FontAwesomeIcons.locationArrow);
        // _widgetOrder = [_favoritesComponent(), Spacing(height: 40).sliver(), nearMe];

        // // if there are no favorites, swap the position of favorites and near me
        // List favorites = await FavoritesProvider.getFavorites(simplified: true);
        // if (favorites.isEmpty) {
        //   // even if the SF list is empty, there may be bus stops which are not near us. That's why
        //   // we check if the list is empty, then check the ACTUAL amount of favorites
        //   // if it's more than 0, it means that it's not showing

        //   // so just to make it clear to the user, display a message:
        //   // You have 3 favorites, which are not near you.

        //   var noFavorites = (await FavoritesProvider.getFavorites(simplified: false)).length;
        //   _widgetOrder = [
        //     nearMe,
        //     Spacing(height: 40).sliver(),
        //     _favoritesComponent(favoritesNotShown: noFavorites)
        //   ];
        // }
      });
    }
  }

  Future order(BuildContext context) async {
    Widget nearMe = BusStopList(title: 'NEAR ME', iconData: FontAwesomeIcons.locationArrow);
    _widgetOrder = [_favoritesComponent(), Spacing(height: 40).sliver(), nearMe];

    // if there are no favorites, swap the position of favorites and near me
    List favorites = await FavoritesProvider.getFavorites(simplified: true);
    if (favorites.isEmpty) {
      // even if the SF list is empty, there may be bus stops which are not near us. That's why
      // we check if the list is empty, then check the ACTUAL amount of favorites
      // if it's more than 0, it means that it's not showing

      // so just to make it clear to the user, display a message:
      // You have 3 favorites, which are not near you.

      var noFavorites = (await FavoritesProvider.getFavorites(simplified: false)).length;
      _widgetOrder = [
        nearMe,
        Spacing(height: 40).sliver(),
        _favoritesComponent(favoritesNotShown: noFavorites)
      ];
    }
    return _widgetOrder;
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: order(context),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (!snapshot.hasData) {
    //       print("snapshot no data");
    //     } else {
    //       print('snapshot has data');
    //       print(snapshot.data);
    //     }
        return PageTemplate(
          children: [
            // if (!snapshot.hasData) Text("Loading").sliverToBoxAdapter() else ...snapshot.data
            // ..._widgetOrder
            Text('test')
          ],
        );
  }

  Widget _favoritesComponent({int favoritesNotShown = 0}) => FavoritesBusStopList(
        title: 'FAVORITES',
        iconData: FontAwesomeIcons.heart,
        simplified: true,
        favoritesNotShown: favoritesNotShown,
      );
}
