import 'package:flutter/material.dart';

import 'generated/i18n.dart';
import 'server.dart';
import 'util.dart';

class RegisterPage extends StatefulWidget {
  final Server server;

  RegisterPage({
    Key key,
    @required this.server,
  }) : super(key: key);

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).registrationTitle)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('Setup profile')],
          ),
        ],
      ),
      drawer: getNavDrawer(context),
    );
  }
}
