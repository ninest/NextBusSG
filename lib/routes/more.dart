import 'package:flutter/material.dart';
import 'package:nextbussg/components/more/more_buttons_list.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:nextbussg/components/more/settings/settings_list.dart';
import 'package:nextbussg/components/more/settings/toggle_tile.dart';
import 'package:nextbussg/components/core/title_text.dart';
import 'package:nextbussg/components/core/line.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/components/core/space.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(children: [
      TitleText(title: 'MORE').sliverToBoxAdapter(),
      SettingsList(),
      Line().sliverToBoxAdapter(),
      Spacing(height: 10).sliver(),
      MoreButtonsList(),
    ]);
  }
}
