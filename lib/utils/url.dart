import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

void openUrl(String url) async {
  if (await canLaunch(url))
    await launch(url);
  else
    throw 'Could not launch $url';
}

openMap(lon, lat) {
  String url;
  if (Platform.isIOS)
    url = 'https://maps.apple.com/?q=$lat,$lon';
  else
    url = 'https://www.google.com/maps?q=$lat,$lon';
  openUrl(url);
}
