
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:hive/hive.dart';
import 'package:nextbussg/tabbed_app.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:nextbussg/utils/theme_enum.dart';
import 'dart:io';
import 'package:nextbussg/styles/theme.dart';
import 'package:nextbussg/utils/bounce_scroll.dart';
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
        Widget home = firstLaunch ? OnboardingView() : TabbedApp();

        // change status bar color accordingly, fix for android
        if (Platform.isAndroid) {
          if (theme == ThemeEnum.light) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.white.withOpacity(0.5),
              statusBarIconBrightness: Brightness.dark,
            ));
          } else {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
            ));
          }
        } else if (Platform.isIOS) {
          if (theme == ThemeEnum.light) {
            FlutterStatusbarcolor.setStatusBarColor(Colors.white.withOpacity(0.5));
            FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
          } else {
            FlutterStatusbarcolor.setStatusBarColor(Color(0xcc111111));
            FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
          }
        }

        return BotToastInit(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Next Bus SG',
            theme: theme == ThemeEnum.dark ? appDarkTheme : appLightTheme,
            // nice IOS rubber band scrolling
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
