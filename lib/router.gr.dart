// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:nextbussg/tabbed_app.dart';
import 'package:nextbussg/routes/home.dart';
import 'package:nextbussg/routes/search.dart';
import 'package:nextbussg/routes/more.dart';
import 'package:nextbussg/components/search/service_page/service_page.dart';
import 'package:nextbussg/components/search/stop_page/stop_overview_page.dart';

abstract class Routes {
  static const tabbedApp = '/';
  static const homePage = '/home-page';
  static const searchPage = '/search-page';
  static const morePage = '/more-page';
  static const servicePage = '/service-page';
  static const stopOverviewPage = '/stop-overview-page';
}

class Router extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.tabbedApp:
        return MaterialPageRoute<dynamic>(
          builder: (_) => TabbedApp(),
          settings: settings,
        );
      case Routes.homePage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => HomePage(),
          settings: settings,
        );
      case Routes.searchPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SearchPage(),
          settings: settings,
        );
      case Routes.morePage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => MorePage(),
          settings: settings,
        );
      case Routes.servicePage:
        if (hasInvalidArgs<ServicePageArguments>(args)) {
          return misTypedArgsRoute<ServicePageArguments>(args);
        }
        final typedArgs =
            args as ServicePageArguments ?? ServicePageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => ServicePage(service: typedArgs.service),
          settings: settings,
        );
      case Routes.stopOverviewPage:
        if (hasInvalidArgs<StopOverviewPageArguments>(args)) {
          return misTypedArgsRoute<StopOverviewPageArguments>(args);
        }
        final typedArgs =
            args as StopOverviewPageArguments ?? StopOverviewPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => StopOverviewPage(code: typedArgs.code),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//ServicePage arguments holder class
class ServicePageArguments {
  final String service;
  ServicePageArguments({this.service});
}

//StopOverviewPage arguments holder class
class StopOverviewPageArguments {
  final String code;
  StopOverviewPageArguments({this.code});
}
