import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'user.dart';

FirebaseUser _firebaseUser;
// URL of server with a trailing slash
const String endpoint = 'http://192.168.0.126:8000/';
User user;

bool serverConnectionInitialized() => _firebaseUser != null;

void setFirebaseUser(FirebaseUser firebaseUser) => _firebaseUser = firebaseUser;

Future<String> _authorizationHeader() async {
  return 'RideGroupFirebaseToken ' + (await _firebaseUser.getIdToken()).token;
}

Future<http.Response> _getRequest(String path) async {
  if (path[0] == '/') path = path.substring(1);
  if (path[path.length - 1] != '/') path += '/';
  return http.get(endpoint + path,
      headers: {HttpHeaders.authorizationHeader: await _authorizationHeader()});
}

Future<http.Response> _postRequest(String path, dynamic body) async {
  if (path[0] == '/') path = path.substring(1);
  if (path[path.length - 1] != '/') path += '/';
  return http.post(endpoint + path,
      headers: {HttpHeaders.authorizationHeader: await _authorizationHeader()},
      body: body);
}

Future<bool> testConnection() async {
  http.Response response = await _getRequest('ping/');
  return response.statusCode == 200;
}

Future<bool> loginFirebaseUser(FirebaseUser firebaseUser) async {
  _firebaseUser = firebaseUser;
  var result = await _authenticate();
  return result;
}

Future<bool> _authenticate() async {
  /**
   * Authenticate the signed in user with the server and set user accordingly
   * Returns true if the user existed on the server and user was updated
   * or false if this is a new user who needs to be registered
   */
  http.Response response =
      await _getRequest('login/').timeout(const Duration(seconds: 10));
  if (response.statusCode != 200) {
    debugPrint('Unable to connect to server');
    throw StateError('Unable to connect to server');
  }
  Map<String, dynamic> jsonUser = json.decode(response.body);
  user = User.fromJson(jsonUser);
  return jsonUser['setup_complete'];
}

/// Register the current User with the server
Future<bool> registerUser() async {
  http.Response response =
      await _postRequest('register/', user.registrationInfo());
  if (response.statusCode != 200) {
    return false;
  }
  user = User.fromJson(json.decode(response.body));
  return true;
}
