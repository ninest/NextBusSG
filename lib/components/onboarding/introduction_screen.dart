import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nextbussg/components/onboarding/page_view_model_template.dart';
import 'package:nextbussg/components/onboarding/text_styles.dart';
import 'package:nextbussg/providers/location_perms.dart';
import 'package:nextbussg/routes/permission.dart';
import 'package:nextbussg/tabbed_app.dart';
import 'package:nextbussg/utils/route.dart';

class OnboardingView extends StatelessWidget {
  PageViewModel tutorial(BuildContext context) {
    return pageViewModelTemplate(
      context,
      "See bus arrival timings",
      "Tap on any **bus stop** to see a list of bus services and timings.",
      Colors.white,
      imageUrl: 'assets/onboard/arrival-timings.png',
    );
  }

  PageViewModel serviceTileTutorial(BuildContext context) {
    return pageViewModelTemplate(
      context,
      "See bus timings and crowd",
      "",
      Colors.white,
      imageUrl: 'assets/onboard/service-tile.png',
    );
  }

  PageViewModel favorites1(BuildContext context) {
    return pageViewModelTemplate(
      context,
      "Add bus services to your favorites ...",
      "Tap on a **bus service** to add or remove them to your favorites.",
      Colors.white,
      imageUrl: 'assets/onboard/favorites.png',
    );
  }

  PageViewModel search1(BuildContext context) {
    return pageViewModelTemplate(
      context,
      "Search for bus stops ...",
      "and view information about them.",
      Colors.white,
      imageUrl: 'assets/onboard/search.png',
    );
  }

  PageViewModel more(BuildContext context) {
    return pageViewModelTemplate(
      context,
      "More ...",
      "See the **MRT map**, use the **dark theme**, **rename** bus stops ...",
      Color(0xFF111111),
      imageUrl: 'assets/onboard/mrt.png',
      dark: true,
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        tutorial(context),
        serviceTileTutorial(context),
        // requestLocation(context),
        favorites1(context),
        search1(context),
        more(context),
      ],
      onDone: () => _finish(context),
      done: Text('Done', style: doneButtonTextStyle(context)),
      showSkipButton: true,
      skip: Text("Skip", style: buttonTextStyle(context)),
      next: Text("Next", style: buttonTextStyle(context)),
      onSkip: () => _finish(context),
      freeze: false,
    );
  }

  _finish(context) async {
    final bool status = await LocationPermsProvider.getPermStatus();

    if (status == true)
      Routing.openFullScreenDialog(context, TabbedApp());
    else
      Routing.openReplacementRoute(context, PermissionRoute());
  }
}
