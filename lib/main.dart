
import 'package:nextbussg/services/provider/favorites.dart';
import 'package:nextbussg/services/provider/search.dart';
import 'package:nextbussg/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:nextbussg/tabbed_app.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Hive.openBox('favorites');

  // transparent status bar Android
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // statusBarColor: Colors.white,
  // ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MainApp();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoritesProvider>(
            create: (_) => FavoritesProvider()),
        ChangeNotifierProvider<SearchProvider>(create: (_) => SearchProvider())
      ],
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      // to change theme
      valueListenable: Hive.box('settings').listenable(),
      builder: (context, box, widget) {
        // let theme =

        return MaterialApp(
          theme: appLightTheme,
          home: TabbedApp(),
        );
      },
    );
  }
}
