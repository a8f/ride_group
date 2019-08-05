import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import 'user.dart';

class Server {
  /// A connection to the server

  final FirebaseUser firebaseUser;
  final endpoint = 'http://10.0.2.2:8000/';
  static User user;

  Server(this.firebaseUser);

  Future<String> authorizationHeader() async {
    return 'RideGroupFirebaseToken ' + await firebaseUser.getIdToken();
  }

  Future<http.Response> getRequest(String path) async {
    debugPrint(path);
    if (path[0] == '/') path = path.substring(1);
    if (path[path.length - 1] != '/') path += '/';
    return http.get(endpoint + path, headers: {HttpHeaders.authorizationHeader: await authorizationHeader()});
  }

  Future<bool> testConnection() async {
    http.Response response = await getRequest('ping/');
    debugPrint(response.headers.toString());
    return response.statusCode == 200;
  }

  Future<bool> authenticate() async {
    /**
     * Authenticate the signed in user with the server and set this.user accordingly
     * Returns true if the user existed on the server and this.user was updated
     * or false if this is a new user who needs to be registered
     */
    http.Response response = await getRequest('login/');
    assert(response.statusCode == 200);
    Map<String, dynamic> jsonUser = json.decode(response.body);
    user = User.fromJson(jsonUser);
    return jsonUser['setupComplete'];
  }

  Future<User> getUser(int userId) {}
}
