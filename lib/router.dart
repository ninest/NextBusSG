import 'package:auto_route/auto_route_annotations.dart';
import 'package:nextbussg/components/search/service_page/service_page.dart';
import 'package:nextbussg/components/search/stop_page/stop_overview_page.dart';
import 'package:nextbussg/routes/home.dart';
import 'package:nextbussg/routes/more.dart';
import 'package:nextbussg/routes/search.dart';
import 'package:nextbussg/tabbed_app.dart';

@MaterialAutoRouter()
class $Router {
  // main pages
  @initial
  TabbedApp tabbedApp;

  HomePage homePage;

  SearchPage searchPage;

  MorePage morePage;

  // sub pages
  ServicePage servicePage;
  StopOverviewPage stopOverviewPage;
}
