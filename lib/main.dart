import 'package:flutter/material.dart';

import 'generated/i18n.dart';
import 'login.dart';
import 'util.dart';
import 'theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
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
