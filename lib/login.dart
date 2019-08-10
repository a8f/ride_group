import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_app.dart';
import 'generated/i18n.dart';
import 'register.dart';
import 'server.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool loginLoading = false, noServerConnection = false, loginError = false;
  bool savedLoginTried = false;

  Future<bool> googleLogin() async {
    setState(() {
      loginLoading = true;
    });
    GoogleSignInAccount account = await googleSignIn.signIn();
    GoogleSignInAuthentication auth = await account.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: auth.idToken, accessToken: auth.accessToken);

    FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(!user.isAnonymous);
    assert(user.getIdToken() != null);
    Server.firebaseUser = user;
    return await Server.authenticate().catchError((error) {
      setState(() {
        noServerConnection = true;
        loginLoading = false;
      });
    });
  }

  asyncGoogleSignIn(BuildContext context) async {
    googleLogin().then((loginResult) async {
      if (loginResult == null) {
        setState(() => noServerConnection = true);
        debugPrint('failed to sign in');
        return;
      }
      if (loginResult) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authMethod', 'google');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BaseApp()));
      } else {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('authMethod');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Register()));
      }
    });
  }

  loginWithSavedMethod(BuildContext context) async {
    setState(() {
      loginError = false;
    });
    final prefs = await SharedPreferences.getInstance();
    String authMethod = prefs.getString('authMethod') ?? '';
    if (authMethod.isEmpty) return;
    switch (authMethod) {
      case 'google':
        asyncGoogleSignIn(context);
        break;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!savedLoginTried) {
      savedLoginTried = true;
      loginWithSavedMethod(context);
    }
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).loginTitle)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GoogleSignInButton(
                onPressed: () {
                  asyncGoogleSignIn(context);
                },
                darkMode: true,
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Visibility(
                    visible: loginLoading,
                    child: SpinKitRing(color: Theme.of(context).accentColor)))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Visibility(
                    visible: noServerConnection,
                    child: Text(S.of(context).serverConnectionFail)))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Visibility(
                    visible: loginError, child: Text(S.of(context).loginError)))
          ]),
        ],
      ),
    );
  }
}
