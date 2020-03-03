import 'package:flutter/material.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/core/buttons/back_button.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/widgets/page_template.dart';
import 'package:nextbussg/widgets/space.dart';

import 'favorites_list.dart';

class AllFavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      showBackButton: true,
      children: [
        
        FavoritesBusStopList(
          title: "ALL FAVORITES",
          iconData: FontAwesomeIcons.heart,
          simplified: false,

          // not required here, just set it to 0
          favoritesNotShown: 0,
        ),
      ],
    ).scaffold();
  }
}
