import 'package:flutter/material.dart';
import 'package:nextbussg/widgets/space.dart';

import 'package:styled_widget/styled_widget.dart';

class PageTemplate extends StatelessWidget {
  final List children;

  PageTemplate({this.children});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          // SliverSpacing(height: 20),
          Spacing(height: 20).sliver(),

          ...children,

          // allow for some overscroll
          // this is a feature, not a bug
          Spacing(height: 140).sliver(),
        ],
      ).padding(horizontal: 18),
    );
  }

  Widget scaffold() {
    return Scaffold(body: this);
  }
}
