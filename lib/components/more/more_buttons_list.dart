import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/more/faq_page.dart';
import 'package:nextbussg/components/more/mrt_map_page.dart';
import 'package:nextbussg/components/more/tile_button.dart';
import 'package:nextbussg/components/onboarding/introduction_screen.dart';
import 'package:nextbussg/utils/route.dart';

class MoreButtonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          TileButton(
            text: "View MRT map",
            icon: FontAwesomeIcons.train,
            onTap: () => Routing.openRoute(context, MRTMapPage()),
          ),
          TileButton(
            text: "FAQ",
            icon: FontAwesomeIcons.question,
            onTap: () => Routing.openRoute(context, FAQPage()),
          ),
          TileButton(
            text: "View tutorial",
            icon: FontAwesomeIcons.stickyNote,
            onTap: () => Routing.openReplacementRoute(context, OnboardingView()),
          ),
        ],
      ),
    );
  }
}
