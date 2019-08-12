import 'package:flutter/material.dart';

import 'generated/i18n.dart';
import 'server.dart';
import 'util.dart';

class Rides extends StatelessWidget implements AppBarPageBase {
  @override
  Widget build(BuildContext context) {
    // TODO
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[]),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('My Rides')])
      ],
    ));
  }

  @override
  AppBar getAppBar(BuildContext context) =>
      new AppBar(title: Text(S.of(context).ridesAppBarTitle(user.firstName)));
}
