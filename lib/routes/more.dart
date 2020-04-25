import 'package:flutter/material.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/components/more/more_buttons_list.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:nextbussg/components/more/settings/settings_list.dart';
import 'package:nextbussg/components/core/title_text.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/constants/strings.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(children: [
      Column(children: [
        TitleText(title: Strings.moreTitle.toUpperCase()),

        Spacing(height: Values.marginBelowTitle / 2),
        SettingsList(),

        // divider
        Spacing(height: Values.marginBelowTitle),

        MoreButtonsList(),
      ]).sliverToBoxAdapter()
    ]).scaffold();
  }
}
