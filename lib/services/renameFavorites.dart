import 'package:hive/hive.dart';

class RenameFavoritesService {
  static rename(String code, String newName) {
    var settingsBox = Hive.box('settings');
    var prevRenamedFavorites = settingsBox.get('renamed_favorites', defaultValue: {});
    // first remove the previ
    // prevRenamedFavorites.add({
    //   'code': code,
    //   'name': newName,
    // });
    print(code);
    print(newName);
    print(prevRenamedFavorites);
    prevRenamedFavorites[code] = newName;

    settingsBox.put('renamed_favorites', prevRenamedFavorites);
    print('Renamed $code to $newName');
  }

  static getName(String code) {
    var settingsBox = Hive.box('settings');
    var renamedFavorites = settingsBox.get('renamed_favorites', defaultValue: {});
    if (renamedFavorites.isEmpty) {
      return null;
    } else {
      try {
      var stop = renamedFavorites[code];
      return stop;
      } catch(e) {
        print("This does not exist as a renamed favorite");
        return null;
      }
    }
  }
}
