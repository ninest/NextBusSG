import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/components/more/faq_page.dart';
import 'package:nextbussg/components/more/mrt_map_page.dart';
import 'package:nextbussg/components/more/tile_button.dart';
import 'package:nextbussg/components/onboarding/introduction_screen.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/route.dart';
import 'package:nextbussg/utils/url.dart';

class MoreButtonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TileButton(
          text: "View MRT map",
          icon: FontAwesomeIcons.train,
          onTap: () => Routing.openFullScreenDialog(context, MRTMapPage()),
        ),
        TileButton(
          text: "FAQ",
          icon: FontAwesomeIcons.question,
          onTap: () => Routing.openRoute(context, FAQPage()),
        ),
        TileButton(
          text: "View tutorial",
          icon: FontAwesomeIcons.stickyNote,
          onTap: () => Routing.openFullScreenDialog(context, OnboardingView()),
        ),

        // divider
        Spacing(height: Values.marginBelowTitle),

        // other stuff
        TileButton(
          text: "GitHub",
          icon: FontAwesomeIcons.github,
          onTap: () {
            print("Opening github page");
            openUrl("https://github.com/themindstorm/NextBusSG");
          },
        ),

        TileButton(
          text: "View licenses",
          icon: FontAwesomeIcons.scroll,
          onTap: () {
            showLicensePage(context: context);
          },
        )
      ],
    );
  }
}
