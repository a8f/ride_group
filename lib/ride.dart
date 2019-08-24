import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'user.dart';
import 'util.dart';
import 'vehicle.dart';

class Ride {
  int id = -1;
  Vehicle vehicle;
  var passengers = List<User>();
  User driver;
  Place start, end;
  DateTime time;
  String title, description;

  Ride(this.vehicle, this.driver, this.title, this.description, this.start,
      this.end, this.time,
      {this.id, this.passengers});

  Ride.fromJson(Map<String, dynamic> rideJson) {
    id = rideJson['id'];
    driver = User.fromJson(rideJson['owner']);
    start = Place(
        rideJson['start_loc_name'],
        LatLng(rideJson['start_loc']['latitude'],
            rideJson['start_loc']['longitude']));
    end = Place(
        rideJson['end_loc_name'],
        LatLng(
            rideJson['end_loc']['latitude'], rideJson['end_loc']['longitude']));
    title = rideJson['title'];
    description = rideJson['description'];
    vehicle = Vehicle.fromJson(rideJson['vehicle']);
    passengers = (rideJson['passengers'] as List)
        .map((p) => new User.fromJson(p))
        .toList();
    time = DateTime.parse(rideJson['time']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'vehicle': vehicle.toJson(),
        'time': time.toIso8601String(),
        'start_loc_name': start.name,
        'start_loc':
            '{"latitude": ${start.latLng.latitude}, "longitude": ${start.latLng.longitude}}',
        'end_loc_name': end.name,
        'end_loc':
            '{"latitude": ${end.latLng.latitude}, "longitude": ${end.latLng.longitude}}',
        'owner': driver.toJson(),
        'title': title,
        'description': description
      };

  int remainingSeats() => vehicle.seats - (passengers.length + 1);

  String toString() {
    return '$id ($title $description)';
  }
}
