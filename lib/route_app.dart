import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nextbussg/tabbed_app.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:nextbussg/utils/theme_enum.dart';
import 'dart:io' show Platform;
import 'package:nextbussg/styles/theme.dart';
import 'package:nextbussg/bounce_scroll.dart';
import 'package:nextbussg/components/onboarding/introduction_screen.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RouteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      // to change theme and put away onboarding screen
      valueListenable: Hive.box('settings').listenable(),
      builder: (context, box, widget) {
        var theme = box.get('theme', defaultValue: ThemeEnum.light);

        // check if this is the first time using the app
        var settingsBox = Hive.box('settings');
        bool firstLaunch = settingsBox.get('first_launch', defaultValue: true);

        // set firstLaunch to false so that the onboarding view does not show
        Widget home;
        if (firstLaunch)
          home = new OnboardingView();
        else {
          home = new TabbedApp();
        }

        // change status bar color accordingly, fix for android
        if (Platform.isAndroid) {
          if (theme == ThemeEnum.light) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ));
          } else {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
            ));
          }
        }

        return BotToastInit(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme == ThemeEnum.dark ? appDarkTheme : appLightTheme,
            home: ScrollConfiguration(
              child: home,
              behavior: BounceScrollBehavior(),
            ),
            navigatorObservers: [BotToastNavigatorObserver()],
          ),
        );
      },
    );
  }
}
