import 'package:flutter/material.dart';
import 'package:nextbussg/extensions.dart';
import 'package:nextbussg/components/more/settings_list.dart';
import 'package:nextbussg/components/more/toggle_tile.dart';
import 'package:nextbussg/components/title_text.dart';
import 'package:nextbussg/widgets/page_template.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(children: [
      TitleText(title: 'MORE').sliverToBoxAdapter(),
      SettingsList(),
    ]);
  }
}
