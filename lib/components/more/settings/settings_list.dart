import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:nextbussg/components/more/rename_favorites/rename_favorites_page.dart';
import 'package:nextbussg/components/more/settings/toggle_tile.dart';
import 'package:nextbussg/components/more/tile_button.dart';
import 'package:nextbussg/services/theme.dart';
import 'package:nextbussg/utils/route.dart';
import 'package:nextbussg/utils/theme_enum.dart';

class SettingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeEnum theme = ThemeService.getTheme();
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          ToggleTile(
            title: "Enable dark theme",
            icon: FontAwesomeIcons.moon,
            isSwitched: theme == ThemeEnum.dark ? true : false,
            // even though it is a switch and not a button, we can just toggle because
            // the isSwitced value is being set accordinly
            onChange: (bool value) => ThemeService.toggleTheme(),
          ),
          TileButton(
            text: "Rename favorites",
            icon: FontAwesomeIcons.star,
            // open favorites renaming page
            onTap: () => Routing.openRoute(context, RenameFavoritesPage()),
          )
        ],
      ),
    );
  }
}
