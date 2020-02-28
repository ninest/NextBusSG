import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/widgets/page_template.dart';
import 'package:nextbussg/widgets/space.dart';

import 'favorites_list.dart';

class AllFavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTemplate(
        children: [
          Spacing(height: Values.marginBelowTitle).sliver(),
          FavoritesBusStopList(
            title: "ALL FAVORITES",
            iconData: FontAwesomeIcons.heart,
            simplified: false,

            // not required here, just set it to 0
            favoritesNotShown: 0,
          ),
        ],
      ),
    );
  }
}
