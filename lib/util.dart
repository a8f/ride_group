import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home.dart';
import 'profile.dart';
import 'server.dart';
import 'theme.dart';

const EdgeInsets FORM_PADDING =
    EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0);
const EdgeInsets SUBMIT_BUTTON_PADDING = EdgeInsets.symmetric(vertical: 16.0);

abstract class AppBarPageBase {
  AppBar getAppBar(BuildContext context);
}
