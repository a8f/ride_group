import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'server.dart';
import 'theme.dart';
import 'user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:intl/intl.dart';

const EdgeInsets FORM_PADDING =
    EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0);
const EdgeInsets SUBMIT_BUTTON_PADDING = EdgeInsets.symmetric(vertical: 16.0);

DateFormat defaultDateFormat = DateFormat();

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

class Ride {
  int id = -1;
  Vehicle vehicle;
  var passengers = List<User>();
  User driver;
  Place start, end;
  DateTime time;
  String name, description;

  Ride(this.vehicle, this.driver, this.name, this.description, this.start,
      this.end, this.time,
      {this.id, this.passengers});

  Map<String, dynamic> toJson() => {
        'id': id,
        'vehicle': vehicle.toJson(),
        'time': time.toIso8601String(),
        'start_loc': start.name,
        'start_lat': start.latLng.latitude,
        'start_long': start.latLng.longitude,
        'end_loc': end.name,
        'end_lat': end.latLng.latitude,
        'end_long': end.latLng.longitude,
        'owner': driver.toJson(),
        'name': name,
        'description': description
      };

  int remainingSeats() => vehicle.seats - (passengers.length + 1);
}

class Place {
  LatLng latLng;
  String name;

  Place(this.name, this.latLng);

  Place.fromLocationResult(LocationResult locationResult) {
    name = locationResult.address;
    latLng = locationResult.latLng;
  }

  toString() => name ?? '${latLng.latitude}, ${latLng.longitude}';
}
