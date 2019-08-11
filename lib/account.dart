import 'package:flutter/material.dart';

import 'generated/i18n.dart';
import 'server.dart';
import 'util.dart';

class Account extends StatelessWidget implements AppBarPage {
  @override
  Widget build(BuildContext context) {
    // TODO
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text(Server.user.username)],
          )
        ],
      ),
    );
  }

  @override
  AppBar getAppBar(BuildContext context) => new AppBar(title: Text('$Server'));
}
