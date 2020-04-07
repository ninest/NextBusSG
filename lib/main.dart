

import 'package:nextbussg/providers/favorites.dart';
import 'package:nextbussg/providers/home_rebuilder.dart';
import 'package:nextbussg/providers/locationPerms.dart';
import 'package:nextbussg/providers/search.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nextbussg/utils/theme_enum.dart';
import 'package:provider/provider.dart';


void main() async {
  await Hive.initFlutter();

  await Hive.registerAdapter(ThemeEnumAdapter());
  // final appDocumentDir = await getApplicationDocumentsDirectory();
  // await Hive.init(appDocumentDir.path);

  await Hive.openBox('settings');
  await Hive.openBox('favorites');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MainApp();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoritesProvider>(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider<SearchProvider>(create: (_) => SearchProvider()),
        ChangeNotifierProvider<LocationPermissionsProvider>(
            create: (_) => LocationPermissionsProvider()),
        ChangeNotifierProvider<HomeRebuilderProvider>(create: (_) => HomeRebuilderProvider()),
      ],
      child: RouteApp(),
    );
  }
}

