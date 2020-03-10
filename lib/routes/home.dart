import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/core/location_access_button.dart';
// import 'package:nextbussg/components/core/location_access_button.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/components/core/title_text.dart';
import 'package:nextbussg/components/home/bus_stop_list.dart';
import 'package:nextbussg/components/home/favorites/favorites_list.dart';
import 'package:nextbussg/providers/favorites.dart';
import 'package:nextbussg/providers/locationPerms.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final List<Widget> noLocationAccess = [
    TitleText(
      title: "One more step ...",
    ).sliverToBoxAdapter(),
    Spacing(height: Values.marginBelowTitle).sliver(),
    Text("We require your location to find all the bus stops near you!").sliverToBoxAdapter(),
    Spacing(height: Values.marginBelowTitle).sliver(),
    LocationAccessButton().sliverToBoxAdapter()
  ];
  // final List<Widget> yesLocationAccess = [
  //   Text("Thank you!").sliverToBoxAdapter(),
  // ];
  Widget yesLocationAccess(context) => FutureBuilder(
        future: order(context),
        builder: (context, snapshot) {
          return PageTemplate(children: [
            if (!snapshot.hasData) Text("Loading bus stops").sliverToBoxAdapter() else ...snapshot.data,
          ]);
        },
      );

  @override
  Widget build(BuildContext context) {
    final LocationPermissionsProvider locationPermissionsProvider =
        Provider.of<LocationPermissionsProvider>(context, listen: true);

    print("Home widget rebuilt.");

    return FutureBuilder(
      future: locationPermissionsProvider.getBoolPermissionStatus,
      builder: (context, snapshot) {
        // if (snapshot.hasData) {
        //   if (snapshot.data == true)
        //     // location access given
        //     return yesLocationAccess(context);
        //   else
        //     // no location access givenƒ
        //     return Text('no loc');
        // } else {
        //   return Text('no data');
        // }
        if (snapshot.hasData)
          if (snapshot.data == true)
            return yesLocationAccess(context);
          else
            return PageTemplate(children: noLocationAccess);
        else
          return Text("Loading");
      },
    );
  }

  Widget simplifiedFavoritesView({int favoritesNotShown = 0}) => FavoritesBusStopList(
        title: 'Favorites',
        iconData: FontAwesomeIcons.heart,
        simplified: true,
        favoritesNotShown: favoritesNotShown,
      );

  Future order(context) async {
    Widget nearMe = BusStopList(title: 'NEAR ME', iconData: FontAwesomeIcons.locationArrow);

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

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   PermissionStatus _status;
//   List<Widget> _widgetOrder = [Text('Loading ...').sliverToBoxAdapter()];

//   // homePage widgetOrder
//   List<Widget> order() {
//     return [
//       Text('Near me, ...').sliverToBoxAdapter(),
//     ];
//   }

//   @override
//   void initState() {
//     super.initState();
//     _checkStatus();
//   }

//   void _checkStatus() {
//     PermissionHandler()
//         .checkPermissionStatus(PermissionGroup.locationWhenInUse)
//         .then(_updateStatus);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PageTemplate(children: [..._widgetOrder]);
//   }

//   Future _updateStatus(PermissionStatus status) {
//     print("Current permission status: $status");
//     // _status = status;

//     if (status != PermissionStatus.granted) {
//       // permission not granted or unknwon
//       setState(() {
//         _widgetOrder = [
//           TitleText(
//             title: "Location permission required ...",
//           ).sliverToBoxAdapter(),

//           Spacing(height: Values.marginBelowTitle).sliver(),

//           Text("We require your location to find all the bus stops nearby!").sliverToBoxAdapter(),

//           Spacing(height: Values.marginBelowTitle).sliver(),

//           // LocationAccessButton().sliverToBoxAdapter(),
//           _locationButton(),
//         ];
//       });
//     } else {
//       // permission granted, show UI
//       print('permission gratned');

//       setState(() {
//         _widgetOrder = [Text('Thanks for the permission').sliverToBoxAdapter()];
//       });
//     }
//   }

//   Widget _locationButton() {
//     return GestureDetector(
//       child: Text('Grant location access'),
//       onTap: () {
//         print('acesing loc');
//         LocationAccessButton().requestLocationAccess(context).then(
//           setState(() {
//             _widgetOrder = [Text('butt orese').sliverToBoxAdapter()];
//           }),
//         );
//       },
//     ).sliverToBoxAdapter();
//   }
// }
