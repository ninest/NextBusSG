import 'package:flutter/material.dart';
import 'package:nextbussg/components/core/buttons/back_button.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/components/core/space.dart';

class PageTemplate extends StatelessWidget {
  final List children;
  final bool showBackButton;

  PageTemplate({this.children, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Values.pageHorizontalPadding),
        child: CustomScrollView(
          slivers: <Widget>[
            // if (showBackButton)
            if (showBackButton) ...[
              Spacing(height: Values.marginBelowTitle).sliver(),
              Container(child: AppBackButton()).sliverToBoxAdapter(),
              Spacing(height: Values.marginBelowTitle).sliver()
            ] else
              Spacing(height: 20).sliver(),

            ...children,

            // allow for some overscroll
            // this is a feature, not a bug
            Spacing(height: 140).sliver(),
          ],
        ),
      ),
    );
  }

  Widget scaffold() {
    return Scaffold(body: this);
  }
}
