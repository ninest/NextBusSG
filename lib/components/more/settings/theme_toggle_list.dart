import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/more/tile_button.dart';
import 'package:nextbussg/services/theme.dart';
import 'package:nextbussg/styles/tile_color.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/theme_enum.dart';

class ThemeToggleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TileButton(
      text: "Choose theme",
      icon: FontAwesomeIcons.moon,
      children: <Widget>[
        _option(context, "Light theme", ThemeEnum.light),
        _option(context, "Dark theme", ThemeEnum.dark),
        // _option(context, "System", ThemeEnum.system),
      ],
    );
  }

  Widget _option(BuildContext context, String text, ThemeEnum themeEnum) => InkWell(
        borderRadius: BorderRadius.circular(Values.borderRadius / 2),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Values.borderRadius / 2),
            color: ThemeService.getTheme() == themeEnum
                ? Theme.of(context).primaryColor
                : TileColors.busServiceTile(context),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.body1.copyWith(
                  // change font weight depending on which theme is selected
                  fontWeight:
                      ThemeService.getTheme() == themeEnum ? FontWeight.w700 : FontWeight.w400,
                  color: ThemeService.getTheme() == themeEnum
                      ? Colors.white70
                      : Theme.of(context).textTheme.body1.color,
                ),
          ),
        ),
        onTap: () {
          ThemeService.setTheme(themeEnum);
        },
      );
}
