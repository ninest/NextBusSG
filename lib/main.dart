import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:nextbussg/components/more/mrt_map_page.dart';
import 'package:nextbussg/components/onboarding/introduction_screen.dart';
import 'package:nextbussg/providers/favorites.dart';
import 'package:nextbussg/providers/home_rebuilder.dart';
import 'package:nextbussg/providers/locationPerms.dart';
import 'package:nextbussg/providers/search.dart';
import 'package:nextbussg/routes/search.dart';
import 'package:nextbussg/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nextbussg/utils/route.dart';
import 'package:nextbussg/utils/theme_enum.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:nextbussg/tabbed_app.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:quick_actions/quick_actions.dart';

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

        // change status bar color accordingly
        if (theme == ThemeEnum.dark) {
          // FlutterStatusbarcolor.setStatusBarColor(appDarkTheme.scaffoldBackgroundColor);
          FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
          FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        } else {
          // FlutterStatusbarcolor.setStatusBarColor(Colors.white);
          FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
          FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        }

        return BotToastInit(

          
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme == ThemeEnum.dark ? appDarkTheme : appLightTheme,
            home: home,
            navigatorObservers: [BotToastNavigatorObserver()],
          ),
        );
      },
    );
  }
}
