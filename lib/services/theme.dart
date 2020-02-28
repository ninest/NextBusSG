import 'package:hive/hive.dart';

class ThemeService {
  // returns 'dark' or 'light
  static String getTheme() {
    var settingsBox = Hive.box('settings');
    var theme = settingsBox.get('theme', defaultValue: 'light');
    return theme;
  }

  static toggleTheme() {
    var settingsBox = Hive.box('settings');
    var theme = settingsBox.get('theme', defaultValue: 'light');
    if (theme == 'light') {
      theme = 'dark';
    } else {
      theme = 'light';
    }
    settingsBox.put('theme', theme);
  }
}
