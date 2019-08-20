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
    start = Place.fromLatLng(
        rideJson['start_loc'], rideJson['start_lat'], rideJson['start_long']);
    end = Place.fromLatLng(
        rideJson['end_loc'], rideJson['end_lat'], rideJson['end_long']);
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
        'start_loc': start.name,
        'start_lat': start.latLng.latitude,
        'start_long': start.latLng.longitude,
        'end_loc': end.name,
        'end_lat': end.latLng.latitude,
        'end_long': end.latLng.longitude,
        'owner': driver.toJson(),
        'title': title,
        'description': description
      };

  int remainingSeats() => vehicle.seats - (passengers.length + 1);

  String toString() {
    return '$id ($title $description)';
  }
}
