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

  // transparent status bar Android
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // statusBarColor: Colors.transparent,
    // statusBarIconBrightness: Brightness.dark,
  ));

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

        // if (theme == 'dark') {
        //   FlutterStatusbarcolor.setStatusBarColor(Color(0xFF111111));
        //   if (useWhiteForeground(Color(0xFF111111))) {
        //     FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        //   } else {
        //     FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        //   }
        // } else {
        //   FlutterStatusbarcolor.setStatusBarColor(Colors.white);
        //   if (useWhiteForeground(Colors.white)) {
        //     FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        //   } else {
        //     FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        //   }
        // }

        // if (theme == 'dark') {
        //   print('d');
        //   FlutterStatusbarcolor.setStatusBarColor(Colors.orange[200]);
        //   if (useWhiteForeground(Colors.orange[200])) {
        //     FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        //   } else {
        //     FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        //   }
        // } else {
        //   FlutterStatusbarcolor.setStatusBarColor(Colors.green[400]);
        //   if (useWhiteForeground(Colors.green[400])) {
        //     FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        //   } else {
        //     FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        //   }
        // }

        return BotToastInit(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: theme == 'dark' ? ThemeMode.dark : ThemeMode.light,
            theme: theme == 'dark' ? appDarkTheme : appLightTheme,
            // theme: appLightTheme,
            // darkTheme: appDarkTheme,
            home: home,
            navigatorObservers: [BotToastNavigatorObserver()],
          ),
        );
      },
    );
  }
}
