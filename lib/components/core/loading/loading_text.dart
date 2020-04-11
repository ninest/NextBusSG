import 'package:flutter/material.dart';
import 'package:nextbussg/styles/values.dart';

class LoadingText extends StatelessWidget {
  final String text;
  LoadingText({this.text = "Loading ..."});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Values.pageHorizontalPadding,
      ),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Text(
            text,
            style: Theme.of(context).textTheme.title.copyWith(
                  fontSize: Values.em * 1.5,
                ),
          ),
          Text(_getRandomJoke()),
        ],
      ),
    );
  }

  _getRandomJoke() {
    List<String> jokes = [
      "What do you call a group of pandas? A pandemic.",
      "How do you react to a lockdown in Singapore? CB!"
    ];
    // get a random joke
    String randomJoke = (jokes.toList()..shuffle()).first;
    return randomJoke;
  }
}
