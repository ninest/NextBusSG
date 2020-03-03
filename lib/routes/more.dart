import 'package:flutter/material.dart';
import 'package:nextbussg/components/more/other/other_list.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:nextbussg/components/more/settings/settings_list.dart';
import 'package:nextbussg/components/more/settings/toggle_tile.dart';
import 'package:nextbussg/components/core/title_text.dart';
import 'package:nextbussg/widgets/line.dart';
import 'package:nextbussg/widgets/page_template.dart';
import 'package:nextbussg/widgets/space.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(children: [
      TitleText(title: 'MORE').sliverToBoxAdapter(),
      SettingsList(),
      Line().sliverToBoxAdapter(),
      Spacing(height: 10).sliver(),
      OtherList(),
    ]);
  }
}
