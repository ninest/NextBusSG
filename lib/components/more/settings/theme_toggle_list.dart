import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/more/tile_button.dart';
import 'package:nextbussg/services/theme.dart';
import 'package:nextbussg/styles/tile_color.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/theme_enum.dart';

// had to convert this to stateful so it rebuilds itself
class ThemeToggleList extends StatefulWidget {
  @override
  _ThemeToggleListState createState() => _ThemeToggleListState();
}

class _ThemeToggleListState extends State<ThemeToggleList> {
  @override
  Widget build(BuildContext context) {
    return TileButton(
      text: "Choose theme",
      icon: FontAwesomeIcons.moon,
      children: <Widget>[
        _option(context, "Light", ThemeEnum.light),
        _option(context, "Night", ThemeEnum.dark),
        _option(context, "System", ThemeEnum.system),
      ],
    );
  }

  Widget _option(BuildContext context, String text, ThemeEnum themeEnum) => InkWell(
        borderRadius: BorderRadius.circular(Values.borderRadius / 2),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Values.marginBelowTitle, vertical: Values.marginBelowTitle / 1.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Values.borderRadius / 2),
            color: ThemeService.getThemeEnum() == themeEnum
                ? Theme.of(context).primaryColor
                : TileColors.busServiceTile(context),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.body1.copyWith(
                  fontSize: Values.em * 0.8,
                  // change font weight depending on which theme is selected
                  fontWeight:
                      ThemeService.getThemeEnum() == themeEnum ? FontWeight.w700 : FontWeight.w400,
                  color: ThemeService.getThemeEnum() == themeEnum
                      ? Colors.white70
                      : Theme.of(context).textTheme.body1.color,
                ),
          ),
        ),
        onTap: () =>
          // rebuild widget (not sure why this is requrired)
          setState(() => ThemeService.setTheme(context, themeEnum))
        ,
      );
}
