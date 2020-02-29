import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/more/mrt_map_page.dart';
import 'package:nextbussg/components/more/tile_button.dart';

class OtherList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          TileButton(
            text: "View MRT map",
            icon: FontAwesomeIcons.train,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MRTMapPage()));
            },
          ),
        ],
      ),
    );
  }
}
