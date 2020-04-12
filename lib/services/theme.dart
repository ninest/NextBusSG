import 'package:hive/hive.dart';
import 'package:nextbussg/utils/theme_enum.dart';

class ThemeService {
  // returns 'dark' or 'light
  static ThemeEnum getTheme() {
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

  static setTheme(ThemeEnum themeEnum) {
    var settingsBox = Hive.box('settings');
    settingsBox.put('theme', themeEnum);
  }
}
