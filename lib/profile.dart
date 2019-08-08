import 'package:flutter/material.dart';

import 'generated/i18n.dart';
import 'user.dart';
import 'util.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).loginTitle)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('Logged in')],
          )
        ],
      ),
      drawer: getNavDrawer(context),
    );
  }
}
