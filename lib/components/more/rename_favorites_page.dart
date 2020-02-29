import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nextbussg/components/more/tile_button.dart';
import 'package:nextbussg/components/title_text.dart';
import 'package:nextbussg/extensions.dart';
import 'package:nextbussg/services/provider/favorites.dart';
import 'package:nextbussg/services/renameFavorites.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/widgets/page_template.dart';
import 'package:nextbussg/widgets/space.dart';

class RenameFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FavoritesProvider.getFavorites(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData)
          return PageTemplate(
            showBackButton: true,
            children: [
              TitleText(
                title: "Renaming favorites",
              ).sliverToBoxAdapter(),
              Spacing(height: 10).sliver(),
              MarkdownBody(
                data: "Tap any of the bus stop names below to change their display name:",
              ).sliverToBoxAdapter(),
              Spacing(height: 10).sliver(),

              for (var bs in snapshot.data)
                // Text('bus stop fav').sliverToBoxAdapter()
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: Values.marginBelowTitle),
                    child: Text(
                      "${bs.name} – ${bs.code}",
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  onTap: () => _changeDisplayName(bs.code),
                ).sliverToBoxAdapter(),
              // display all favorites
            ],
          ).scaffold();
        else
          return Text("Loading");
      },
    );
  }

  _changeDisplayName(String code) {
    print('test');
    RenameFavoritesService.rename(code, "3 interchange");
  }
}
