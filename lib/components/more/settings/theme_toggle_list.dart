import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/more/tile_button.dart';
import 'package:nextbussg/services/theme.dart';
import 'package:nextbussg/utils/theme_enum.dart';

class ThemeToggleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TileButton(
      text: "Choose theme",
      icon: FontAwesomeIcons.moon,
      children: <Widget>[
        _themeCheckboxTile("Light theme", ThemeEnum.light),
        _themeCheckboxTile("Dark theme", ThemeEnum.dark),
        // _themeCheckboxTile("System default"),
      ],
    );
  }

  Widget _themeCheckboxTile(String text, ThemeEnum themeEnum) => ListTileTheme(
        contentPadding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 0,
        ),
        child: CheckboxListTile(
          // if current theme is themeEnum, it should be checked
          value: ThemeService.getTheme() == themeEnum,
          onChanged: (value) {
            print("Setting theme $text");
            ThemeService.setTheme(themeEnum);
          },
          title: Text(text),
        ),
      );
}
