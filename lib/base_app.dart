import 'package:flutter/material.dart';

import 'generated/i18n.dart';
import 'server.dart';
import 'util.dart';
import 'home.dart';
import 'profile.dart';
import 'rides.dart';

class BaseApp extends StatefulWidget {
  /// Base app containing the bottom navigation bar and the widgets for each screen
  BaseAppState createState() => BaseAppState();
}

class BaseAppState extends State<BaseApp> {
  final List<Widget> _screens = [Home(), Rides(), Profile(user: Server.user)];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text(S.of(context).homeNavBarTitle)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: Text(S.of(context).ridesNavBarTitle)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text(S.of(context).profileNavBarTitle))
            ],
            onTap: (i) => setState(() => currentIndex = i)),
        body: _screens[currentIndex]);
  }
}
