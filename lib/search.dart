import 'package:flutter/material.dart';
import 'util.dart';
import 'generated/i18n.dart';

class Search extends StatefulWidget implements AppBarPageBase {
  _SearchState createState() => _SearchState();

  @override
  AppBar getAppBar(BuildContext context) =>
      new AppBar(title: Text(S.of(context).searchAppBarTitle));
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    // TODO
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Center(child: Text('Search'))]));
  }
}
