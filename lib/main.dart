import 'package:nextbussg/providers/favorites.dart';
import 'package:nextbussg/providers/home_rebuilder.dart';
import 'package:nextbussg/providers/location_perms.dart';
import 'package:nextbussg/providers/search.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nextbussg/route_app.dart';
import 'package:nextbussg/services/bus.dart';
import 'package:nextbussg/services/location.dart';
import 'package:nextbussg/utils/theme_enum.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ThemeEnumAdapter());

  await Hive.openBox('settings');
  await Hive.openBox('favorites');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationServicesProvider>(create: (_) => LocationServicesProvider()),
        ChangeNotifierProvider<BusServiceProvider>(create: (_) => BusServiceProvider()),
        ChangeNotifierProvider<FavoritesProvider>(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider<SearchProvider>(create: (_) => SearchProvider()),
        ChangeNotifierProvider<LocationPermsProvider>(create: (_) => LocationPermsProvider()),
        ChangeNotifierProvider<HomeRebuilderProvider>(create: (_) => HomeRebuilderProvider()),
      ],
      child: RouteApp(),
    );
  }
}
