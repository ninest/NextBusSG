import 'package:flutter/material.dart';
import 'package:nextbussg/providers/favorites.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/constants/strings.dart';

import 'favorites_list.dart';

class AllFavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      showBackButton: true,
      children: [
        FavoritesBusStopList(
          title:
              "${Strings.allFavoritesTitle.toUpperCase()} (${FavoritesProvider.getNoFavorites()})",
          iconData: FontAwesomeIcons.heart,
          simplified: false,

          // not required here, just set it to 0
          favoritesNotShown: 0,
        ),
      ],
    ).scaffold();
  }
}
