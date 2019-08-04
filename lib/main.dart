import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'login.dart';
import 'util.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: S().appTitle,
      home: LoginPage(),
      theme: getTheme(context),
      localizationsDelegates: [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
