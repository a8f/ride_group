import 'package:flutter/material.dart';

import 'generated/i18n.dart';
import 'server.dart';

class MyRidesPage extends StatelessWidget {
  final Server server;

  MyRidesPage({Key key, @required this.server}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).registrationTitle)),
    );
  }
}
