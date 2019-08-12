import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'util.dart';

class Home extends StatefulWidget implements AppBarPageBase {
  _HomeState createState() => _HomeState();

  @override
  AppBar getAppBar(BuildContext context) =>
      new AppBar(title: Text(S.of(context).homeAppBarTitle));
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // TODO
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Center(child: Text('Home'))]));
  }
}
