import 'package:flutter/material.dart';

import 'vehicle.dart';

class User {
  String username;
  String email;
  String firstName, lastName;
  DateTime dateJoined, lastLogin;
  String phone;
  String photoUrl;
  List<Vehicle> vehicles;
  int id = -1;
  int ridesPassenger, ridesDriver;
  double passengerRating, driverRating;

  User.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    dateJoined = json['date_joined'] == null
        ? null
        : DateTime.parse(json['date_joined']);
    lastLogin =
        json['last_login'] == null ? null : DateTime.parse(json['last_login']);
    phone = json['phone'];
    photoUrl = json['photo_url'];
    id = json['id'];
    ridesPassenger = json['rides_passenger'];
    ridesDriver = json['rides_driver'];
    driverRating = json['rating_driver'];
    passengerRating = json['rating_passenger'];
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'date_joined': dateJoined.toIso8601String(),
        'phone': phone,
        'photoUrl': photoUrl,
        'id': id,
        'rides_passenger': ridesPassenger,
        'rides_driver': ridesDriver,
        'rating_driver': driverRating,
        'rating_passenger': passengerRating
      };

  Map<String, String> registrationInfo() => {
        'username': username,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'username': username,
        'phone': phone
      };

  String fullName() => this.firstName == null
      ? null
      : this.lastName == null
          ? this.firstName
          : this.firstName + " " + this.lastName;
}
