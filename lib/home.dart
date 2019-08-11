import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'util.dart';

class Home extends StatefulWidget implements AppBarPage {
  HomeState createState() => HomeState();

  @override
  AppBar getAppBar(BuildContext context) =>
      new AppBar(title: Text(S.of(context).homeAppBarTitle));
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // TODO
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Center(child: Text('Home'))]));
  }
}
