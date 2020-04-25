import 'package:flutter/material.dart';
import 'package:nextbussg/components/core/buttons/back_button.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/components/core/space.dart';

class PageTemplate extends StatelessWidget {
  final List children;
  final bool showBackButton;
  final bool overscroll;

  PageTemplate({this.children, this.showBackButton = false, this.overscroll = true});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        padding: EdgeInsets.only(
          // top: statusBarHeight,
          left: Values.pageHorizontalPadding,
          right: Values.pageHorizontalPadding,
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            Spacing(height: statusBarHeight).sliver(),
            if (showBackButton)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacing(height: Values.marginBelowTitle),
                  // Using wrap so it doesn't take 100% width
                  Wrap(children: <Widget>[AppBackButton()]),

                  Spacing(height: Values.marginBelowTitle),
                ],
              ).sliverToBoxAdapter()
            else
              Spacing(height: 20).sliver(),

            ...children,

            // allow for some overscroll
            // this is a feature, not a bug
            if (overscroll) ...[
              Spacing(height: 240).sliver(),
            ]
          ],
        ),
      ),
    );
  }

  Widget scaffold() {
    return Scaffold(
      body: this,
    );
  }
}
