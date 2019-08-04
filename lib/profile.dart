import 'package:flutter/material.dart';
import 'util.dart';
import 'generated/i18n.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'user.dart';
import 'server.dart';

class ProfilePage extends StatelessWidget {
  final Server server;
  final User user;

  ProfilePage({
    Key key,
    @required this.server,
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
