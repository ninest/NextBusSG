import 'package:flutter/material.dart';
import 'package:nextbussg/components/title_text.dart';
import 'package:nextbussg/widgets/page_template.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(children: [
      TitleText(title: 'SETTINGS').sliverToBoxAdapter()
    ]);
  }
}
