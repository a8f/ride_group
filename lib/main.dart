import 'package:flutter/material.dart';

import 'generated/i18n.dart';
import 'login.dart';
import 'util.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: S().appTitle,
      home: Login(),
      theme: theme,
      localizationsDelegates: [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
