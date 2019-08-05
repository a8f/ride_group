import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'generated/i18n.dart';
import 'profile.dart';
import 'server.dart';
import 'user.dart';
import 'util.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool loginLoading = false, noServerConnection = false;
  Server server;

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
    this.server = Server(user);
    return server.authenticate();
  }

  @override
  Widget build(BuildContext context) {
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
                  googleLogin().then((loginResult) {
                    if (loginResult) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ProfilePage(
                            server: this.server, user: Server.user);
                      }));
                    } else {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return RegisterPage(
                            server: this.server);
                      }));
                    }
                  });
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
          ])
        ],
      ),
    );
  }
}
