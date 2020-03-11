import 'package:flutter/material.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/search/text_box.dart';
import 'package:nextbussg/components/search/results_list.dart';
import 'package:nextbussg/components/core/title_text.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/utils/strings.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      children: [
        TitleText(title: Strings.searchTitle.toUpperCase(), iconData: FontAwesomeIcons.search).sliverToBoxAdapter(),
        SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: SearchBoxPersistentHeaderDelegate(
            minExtent: 70.0,
            maxExtent: 70.0,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SearchResultsList(),
            ],
          ),
        )
      ],
    );
  }
}

class SearchBoxPersistentHeaderDelegate implements SliverPersistentHeaderDelegate {
  SearchBoxPersistentHeaderDelegate({
    this.minExtent,
    @required this.maxExtent,
  });
  final double minExtent;
  final double maxExtent;

  @override
  build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SearchTextBox();
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
