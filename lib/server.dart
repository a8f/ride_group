import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'user.dart';

class Server {
  /// The connection to the server

  static FirebaseUser firebaseUser;
  static final endpoint = 'http://10.0.2.2:8000/';
  static User user;

  static bool isInitialized() => firebaseUser != null;

  static Future<String> authorizationHeader() async {
    return 'RideGroupFirebaseToken ' + await firebaseUser.getIdToken();
  }

  static Future<http.Response> getRequest(String path) async {
    if (path[0] == '/') path = path.substring(1);
    if (path[path.length - 1] != '/') path += '/';
    return http.get(endpoint + path, headers: {
      HttpHeaders.authorizationHeader: await authorizationHeader()
    });
  }

  static Future<http.Response> postRequest(String path, dynamic body) async {
    debugPrint(path);
    if (path[0] == '/') path = path.substring(1);
    if (path[path.length - 1] != '/') path += '/';
    return http.post(endpoint + path,
        headers: {HttpHeaders.authorizationHeader: await authorizationHeader()},
        body: body);
  }

  static Future<bool> testConnection() async {
    http.Response response = await getRequest('ping/');
    debugPrint(response.headers.toString());
    return response.statusCode == 200;
  }

  static Future<bool> authenticate() async {
    /**
     * Authenticate the signed in user with the server and set this.user accordingly
     * Returns true if the user existed on the server and this.user was updated
     * or false if this is a new user who needs to be registered
     */
    http.Response response =
        await getRequest('login/').timeout(const Duration(seconds: 10));
    debugPrint(response.toString());
    if (response.statusCode != 200) {
      throw StateError('Unable to connect to server');
    }
    debugPrint(response.body);
    Map<String, dynamic> jsonUser = json.decode(response.body);
    user = User.fromJson(jsonUser);
    return jsonUser['setup_complete'];
  }

  static Future<bool> registerUser() async {
    /// Register the current User with the server
    http.Response response =
        await postRequest('register/', Server.user.registrationInfo());
    if (response.statusCode != 200) {
      return false;
    }
    Server.user = User.fromJson(json.decode(response.body));
    return true;
  }
}
