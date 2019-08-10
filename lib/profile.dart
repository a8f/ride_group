import 'package:flutter/material.dart';

import 'generated/i18n.dart';
import 'user.dart';
import 'util.dart';

class Profile extends StatelessWidget {
  final User user;

  Profile({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('Profile of ' + user.username)],
          )
        ],
      ),
    );
  }
}
