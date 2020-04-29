import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RenameFavoritesService {
  static rename(BuildContext context, String code, String newName) {
    var settingsBox = Hive.box('settings');
    var prevRenamedFavorites = settingsBox.get('renamed_favorites', defaultValue: {});

    print(code);
    print(newName);
    print(prevRenamedFavorites);
    prevRenamedFavorites[code] = newName;

    settingsBox.put('renamed_favorites', prevRenamedFavorites);
    print('Renamed $code to $newName');
    BotToast.showText(text: "Renamed to $newName.", contentColor: Theme.of(context).primaryColor);
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
      } catch (e) {
        print("This does not exist as a renamed favorite");
        return null;
      }
    }
  }

  static deleteRename(String code) {
    // removing the rename (setting it to the default)
    // need to delete key in renamed_favorites of settingsBox
    var settingsBox = Hive.box('settings');
    var renamedFavorites = settingsBox.get('renamed_favorites', defaultValue: {});
    try {
      renamedFavorites.remove(code);
      settingsBox.put('renamed_favorites', renamedFavorites);
    } catch (e) {
      print("Error in deleting rename");
    }
    BotToast.showText(text: "Rename removed.", contentColor: Colors.red);
  }
}
