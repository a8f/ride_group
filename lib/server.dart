import 'package:firebase_auth/firebase_auth.dart';

class Server {
  /// A connection to the server

  final FirebaseUser firebaseUser;

  Server(this.firebaseUser);

  Future<bool> authFirebaseUser() async {
    return true;
  }
}
