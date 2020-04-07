import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/routes/home.dart';
import 'package:nextbussg/routes/search.dart';
import 'package:nextbussg/routes/more.dart';

class TabbedApp extends StatefulWidget {
  @override
  TabbedAppState createState() => TabbedAppState();
}

class TabbedAppState extends State<TabbedApp> {
  int _selectedIndex = 0;
  static List<Widget> _tabViews = <Widget>[HomePage(), SearchPage(), MorePage()];

  static const List<BottomNavigationBarItem> _tabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.compass), title: Text('Main')),
    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.search), title: Text('Search')),
    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.slidersH), title: Text('More')),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: make nav bar a little transparent so it looks nice
    return Scaffold(
      body: Stack(
        children: <Widget>[
          IndexedStack(
            index: _selectedIndex,
            children: _tabViews,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
              elevation: 0.0,
              items: _tabs,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              unselectedIconTheme: IconThemeData(size: 26),
              selectedIconTheme: IconThemeData(size: 28),
            ),
          )
        ],
      ),
      // bottomNavigationBar: Container(
      //   child: BottomNavigationBar(
      //     showSelectedLabels: false,
      //     showUnselectedLabels: false,
      //     // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //     backgroundColor: Colors.transparent,
      //     elevation: 0.0,
      //     items: _tabs,
      //     currentIndex: _selectedIndex,
      //     onTap: _onItemTapped,
      //     unselectedIconTheme: IconThemeData(size: 26),
      //     selectedIconTheme: IconThemeData(size: 28),
      //   ),
      // ),
    );
  }
}
