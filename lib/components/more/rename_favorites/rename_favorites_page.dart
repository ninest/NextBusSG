import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nextbussg/components/core/error_container.dart';
import 'package:nextbussg/components/more/rename_favorites/bottom_sheets.dart';
import 'package:nextbussg/components/core/title_text.dart';
import 'package:nextbussg/models/bus_stop.dart';
import 'package:nextbussg/styles/tile_color.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:nextbussg/providers/favorites.dart';
import 'package:nextbussg/constants/strings.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/components/core/space.dart';

class RenameFavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FavoritesProvider.getFavorites(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData)
            return PageTemplate(
              showBackButton: true,
              children: [
                TitleText(
                  title: "Rename favorites",
                ).sliverToBoxAdapter(),
                Spacing(height: 10).sliver(),
                MarkdownBody(
                  data: Strings.renameFavoritesPrompt,
                ).sliverToBoxAdapter(),
                Spacing(height: 20).sliver(),

                if (snapshot.data.isEmpty) ...[
                  ErrorContainer(
                    text: "**Currently no favorites**: ${Strings.noFavorites}",
                  ).sliverToBoxAdapter(),
                  Spacing(height: 20).sliver(),
                ],

                for (var bs in snapshot.data)
                  // Text('bus stop fav').sliverToBoxAdapter()
                  GestureDetector(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: Values.marginBelowTitle),
                        child: _busStopTile(context, bs)),
                    onTap: () => _changeDisplayNameBottomSheet(context, bs.code, bs.name),
                  ).sliverToBoxAdapter(),

                // text below
                MarkdownBody(
                  data: Strings.renameFavoritesPrompt2,
                ).sliverToBoxAdapter(),
                // display all favorites
              ],
            );
          else
            return Text("Loading");
        },
      ),
    );
  }

  _changeDisplayNameBottomSheet(BuildContext context, String code, String name) =>
      // display bottom sheet that takes input using $name as reference
      RenameFavoritesBottomSheets.bs(context, code, name);

  Widget _busStopTile(BuildContext context, BusStop bs) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: Values.busStopTileHorizontalPadding,
          vertical: Values.busStopTileVerticalPadding,
        ),
        decoration: BoxDecoration(
          color: TileColors.busStopExpansionTile(context),
          borderRadius: BorderRadius.circular(Values.borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "${bs.name}",
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              "${bs.code}",
              style: Theme.of(context).textTheme.display2,
            ),
          ],
        ),
      );
}
