import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:nextbussg/components/more/rename_favorites_page.dart';
import 'package:nextbussg/components/more/settings/toggle_tile.dart';
import 'package:nextbussg/components/more/tile_button.dart';
import 'package:nextbussg/services/theme.dart';

class SettingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String theme = ThemeService.getTheme();
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          ToggleTile(
            title: "Enable dark theme",
            icon: FontAwesomeIcons.moon,
            isSwitched: theme == 'dark' ? true : false ,
            onChange: (bool value) {
              // even though it is a switch and not a button, we can just toggle because
              // the isSwitced value is being set accordinly
              ThemeService.toggleTheme();
            },
          ),
          TileButton(
            text: "Rename favorites",
            icon: FontAwesomeIcons.star,
            onTap: () {
              // open favorites renaming page
              Navigator.push(context, MaterialPageRoute(builder: (context) => RenameFavorites()));
            },
          )
        ],
      ),
    );
  }
}
