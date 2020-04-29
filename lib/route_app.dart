import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nextbussg/tabbed_app.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:nextbussg/utils/status_bar_color.dart';
import 'package:nextbussg/utils/theme_enum.dart';
import 'package:nextbussg/styles/theme.dart';
import 'package:nextbussg/utils/bounce_scroll.dart';
import 'package:nextbussg/components/onboarding/introduction_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RouteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      // to change theme and put away onboarding screen
      valueListenable: Hive.box('settings').listenable(),
      builder: (context, box, widget) {
        final theme = box.get('theme', defaultValue: ThemeEnum.light);

        // check if this is the first time using the app
        final settingsBox = Hive.box('settings');
        bool firstLaunch = settingsBox.get('first_launch', defaultValue: true);

        // show onBoarding view if first launch
        Widget home = firstLaunch ? OnboardingView() : TabbedApp();

        ThemeData darkTheme;
        ThemeData regTheme;

        // only if following system theme, set the darkTheme to dark
        if (theme == ThemeEnum.system) {
          darkTheme = appDarkTheme;
          regTheme = appLightTheme;
          print('system theme');
        } else {
          regTheme = theme == ThemeEnum.light ? appLightTheme : appDarkTheme;
        }

        return BotToastInit(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NextBus SG',
            darkTheme: darkTheme,
            theme: regTheme,

            // builder here to get context from MaterialApp
            home: Builder(
              builder: (BuildContext context) {
                // this should also reset when theme changed

                // setStatusBarColor(context);

                // nice IOS rubber band scrolling
                return ScrollConfiguration(
                  child: _buildHome(context, home),
                  behavior: BounceScrollBehavior(),
                );
              },
            ),
            navigatorObservers: [BotToastNavigatorObserver()],
          ),
        );
      },
    );
  }

  Widget _buildHome(BuildContext context, Widget home) {

    // this is already being set from the setTheme function through the change theme button
    // doing it here too so the status bar is the correct color on app launch
    setStatusBarColor(context);

    return ValueListenableBuilder(
      builder: (context, box, widget) {
        return home;
      },
      valueListenable: Hive.box('settings').listenable(),
    );
  }
}
