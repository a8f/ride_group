import 'package:flutter/material.dart';

import 'generated/i18n.dart';
import 'server.dart';
import 'util.dart';
import 'theme.dart';
import 'home.dart';
import 'account.dart';
import 'rides.dart';
import 'search.dart';
import 'create_ride.dart';

class BaseApp extends StatefulWidget {
  /// Base app containing the bottom navigation bar and the widgets for each screen
  BaseAppState createState() => BaseAppState();
}

class BaseAppState extends State<BaseApp> {
  final List<Widget> _screens = [Home(), Rides(), Search(), Account()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (currentIndex < 0 || currentIndex >= _screens.length) {
      debugPrint('Invalid screen index $currentIndex');
      currentIndex = 0;
    }
    return Scaffold(
      appBar: _screens[currentIndex] is AppBarPage
          ? (_screens[currentIndex] as AppBarPage).getAppBar(context)
          : null,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(S.of(context).homeNavBarTitle)),
            BottomNavigationBarItem(
                icon: Icon(Icons.directions_car),
                title: Text(S.of(context).ridesNavBarTitle)),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text(S.of(context).rideSearchNavBarTitle)),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text(S.of(context).accountNavBarTitle))
          ],
          onTap: (i) => setState(() => currentIndex = i)),
      body: _screens[currentIndex],
      floatingActionButton: currentIndex == 1
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => openNewRideCreation(context),
            )
          : null,
    );
  }
}

void openNewRideCreation(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => CreateRide()));
}
