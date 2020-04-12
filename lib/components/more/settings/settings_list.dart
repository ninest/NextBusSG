import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/more/rename_favorites/rename_favorites_page.dart';
import 'package:nextbussg/components/more/settings/theme_toggle_list.dart';
import 'package:nextbussg/components/more/tile_button.dart';
import 'package:nextbussg/utils/route.dart';

class SettingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ThemeToggleList(),
        TileButton(
          text: "Rename favorites",
          icon: FontAwesomeIcons.star,
          // open favorites renaming page
          onTap: () => Routing.openRoute(context, RenameFavoritesPage()),
        )
      ],
    );
  }
}
