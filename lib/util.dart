import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

Drawer getNavDrawer(BuildContext context) {
  return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
    DrawerHeader(
      child: Text(S.of(context).appTitle),
    ),
    ListTile(
      title: Text(S.of(context).myRidesTitle),
      onTap: () {
        // TODO
        Navigator.pop(context);
      },
    )
  ]));
}

ThemeData getTheme(BuildContext context) =>
    ThemeData(primarySwatch: Colors.deepPurple);
