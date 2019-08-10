import 'package:flutter/material.dart';

import 'generated/i18n.dart';
import 'server.dart';

class Rides extends StatelessWidget {
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
}
