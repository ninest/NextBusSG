import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nextbussg/components/more/toggle_tile.dart';
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
            isSwitched: theme == 'dark' ? true : false ,
            onChange: (bool value) {
              // even though it is a switch and not a button, we can just toggle because
              // the isSwitced value is being set accordinly
              ThemeService.toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}
