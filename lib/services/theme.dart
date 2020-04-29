import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nextbussg/utils/status_bar_color.dart';
import 'package:nextbussg/utils/theme_enum.dart';

class ThemeService {
  // returns 'dark' or 'light
  static ThemeEnum getTheme(BuildContext context) {
    var settingsBox = Hive.box('settings');
    var theme = settingsBox.get('theme', defaultValue: ThemeEnum.light);

    if (theme == ThemeEnum.system) {
      if (MediaQuery.of(context).platformBrightness == Brightness.light)
        return ThemeEnum.light;
      else
        return ThemeEnum.dark;
    } else {
      return theme;
    }
  }

  static ThemeEnum getThemeEnum() {
    var settingsBox = Hive.box('settings');
    var theme = settingsBox.get('theme', defaultValue: ThemeEnum.light);
    return theme;
  }

  static toggleTheme() {
    var settingsBox = Hive.box('settings');
    var theme = settingsBox.get('theme', defaultValue: ThemeEnum.light);
    if (theme == ThemeEnum.light) {
      theme = ThemeEnum.dark;
    } else {
      theme = ThemeEnum.light;
    }
    settingsBox.put('theme', theme);
  }

  static setTheme(BuildContext context, ThemeEnum themeEnum) {
    var settingsBox = Hive.box('settings');
    settingsBox.put('theme', themeEnum);

    print("setting $themeEnum");
    setStatusBarColor(context);
    // get theme because if system, it needs to return light or dark
  }
}
