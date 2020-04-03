import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:nextbussg/components/onboarding/introduction_screen.dart';
import 'package:nextbussg/providers/favorites.dart';
import 'package:nextbussg/providers/home_rebuilder.dart';
import 'package:nextbussg/providers/locationPerms.dart';
import 'package:nextbussg/providers/search.dart';
import 'package:nextbussg/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:nextbussg/tabbed_app.dart';
import 'package:bot_toast/bot_toast.dart';

void main() async {
  await Hive.initFlutter();
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
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      // to change theme and put away onboarding screen
      valueListenable: Hive.box('settings').listenable(keys: ['theme']),
      builder: (context, box, widget) {
        var theme = box.get('theme', defaultValue: 'light');

        // check if this is the first time using the app
        var settingsBox = Hive.box('settings');
        bool firstLaunch = settingsBox.get('first_launch', defaultValue: true);

        // set firstLaunch to false so that the onboarding view does not show
        Widget home;
        if (firstLaunch)
          home = OnboardingView();
        else
          home = TabbedApp();

        if (theme == 'dark') {
          FlutterStatusbarcolor.setStatusBarColor(Colors.black);
          FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        } else {
          FlutterStatusbarcolor.setStatusBarColor(Colors.white);
          FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        }

        return BotToastInit(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme == 'dark' ? appDarkTheme : appLightTheme,
            home: home,
            navigatorObservers: [BotToastNavigatorObserver()],
          ),
        );
      },
    );
  }
}
