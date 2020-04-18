import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;
  final IconData iconData;
  TitleText({this.title, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Text(
            title,
            style: Theme.of(context).textTheme.title,
            textAlign: TextAlign.start,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // icon does not have to be provided
        Icon(
          iconData,
          size: Theme.of(context).textTheme.title.fontSize / 1.2,
          color: Theme.of(context).textTheme.title.color,
        )
      ],
    );
  }

  // Widget sliverToBoxAdapter() {
  //   return SliverToBoxAdapter(child: this);
  // }
}
