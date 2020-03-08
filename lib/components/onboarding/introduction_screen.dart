import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nextbussg/components/core/location_access_button.dart';
import 'package:nextbussg/components/onboarding/page_view_model_template.dart';
import 'package:nextbussg/tabbed_app.dart';
import 'package:nextbussg/utils/route.dart';

class OnboardingView extends StatelessWidget {
  PageViewModel tutorial(BuildContext context) {
    return pageViewModelTemplate(
      context,
      "See bus arrival timings",
      "Tap on any bus stop to see a list of bus services and timings. To see bus stops around you, location access is required.",
      Colors.white, //Color(0xFF920077),
      image: Image.asset('assets/onboard/1.png'),
      footer: LocationAccessButton()
    );
  }

  PageViewModel favorites1(BuildContext context) {
    return pageViewModelTemplate(
      context,
      "Add bus services to your favorites ...",
      "Long press or double tap bus services to add or remove them to your favorites. When you open the app to favorites, they will automatically show up.",
      Colors.white,
      image: Image.asset('assets/onboard/2.png'),
    );
  }

  PageViewModel search1(BuildContext context) {
    return pageViewModelTemplate(
      context,
      "Search for bus stops ...",
      "",
      Colors.white,
      image: Image.asset('assets/onboard/4.png'),
    );
  }

  PageViewModel search2(BuildContext context) {
    return pageViewModelTemplate(
      context,
      "... View information about them",
      "See information including a list of operating services, MRT stations nearby, and directions to the stop.",
      Colors.white,
      image: Image.asset('assets/onboard/5.png'),
    );
  }

  PageViewModel more(BuildContext context) {
    return pageViewModelTemplate(
      context,
      "More options ...",
      "See an MRT map, use the dark theme, ...",
      Colors.grey[900],
      image: Image.asset('assets/onboard/6.png'),
      dark: true,
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        tutorial(context),
        favorites1(context),
        search1(context),
        search2(context),
        more(context),
      ],
      onDone: () => _finish(context),
      done: Container(
        child: Text("Done"),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 19.0),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      ),
      skip: Text("Skip"),
      next: Text("Next"),
      onSkip: () => _finish(context),
      freeze: false,
    );
  }

  _finish(context) {
    var settingsBox = Hive.box('settings');
    // bool firstLaunch = settingsBox.get('first_launch', defaultValue: true);
    settingsBox.put('first_launch', false);
    Routing.openReplacementRoute(context, TabbedApp());
  }
}
