import 'package:flutter/material.dart';
import 'package:nextbussg/widgets/sliver_space.dart';

import 'package:styled_widget/styled_widget.dart';

class PageTemplate extends StatelessWidget {
  final List children;

  PageTemplate({this.children});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverSpacing(height: 20),

          ...children,

          // allow for some overscroll
          // this is a feature, not a bug
          SliverSpacing(height: 140),
        ],
      ).padding(horizontal: 18),
    );
  }
}
