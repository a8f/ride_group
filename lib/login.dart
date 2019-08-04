import 'package:flutter/material.dart';
import 'util.dart';
import 'generated/i18n.dart';
import 'profile.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';
import 'server.dart';
import 'package:flutter/foundation.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<Server> googleLogin() async {
    GoogleSignInAccount account = await googleSignIn.signIn();
    GoogleSignInAuthentication auth = await account.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: auth.idToken, accessToken: auth.accessToken);

    FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(!user.isAnonymous);
    assert(user.getIdToken() != null);
    Server server = Server(user);
    assert(await server.authFirebaseUser());
    return server;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).loginTitle)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GoogleSignInButton(
                onPressed: () {
                  googleLogin().then((loginResult) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ProfilePage(
                          server: loginResult, user: User('name', 'email'));
                    }));
                  });
                },
                darkMode: true,
              )
            ],
          )
        ],
      ),
      drawer: getNavDrawer(context),
    );
  }
}
