import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'profile.dart';
import 'server.dart';
import 'theme.dart';
import 'user.dart';

const EdgeInsets FORM_PADDING =
    EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0);
const EdgeInsets SUBMIT_BUTTON_PADDING = EdgeInsets.symmetric(vertical: 16.0);

abstract class AppBarPageBase {
  AppBar getAppBar(BuildContext context);
}

class Vehicle {
  String name, make, model, color, plate;
  bool verified;
  int seats, year, id;

  Vehicle(this.id, this.name, this.make, this.model, this.color, this.plate,
      this.verified, this.seats, this.year);

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    make = json['make'];
    model = json['model'];
    color = json['color'];
    plate = json['plate'];
    verified = false;
    seats = json['seats'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'make': make,
        'model': model,
        'color': color,
        'plate': plate,
        'verified': verified,
        'seats': seats,
        'year': year
      };
}
