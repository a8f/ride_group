import 'util.dart';
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

  User(this.username, this.email, this.firstName, this.lastName,
      this.dateJoined, this.lastLogin, this.phone, this.photoUrl,
      {this.id});

  User.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'date_joined': dateJoined.toIso8601String(),
        'phone': phone,
        'photoUrl': photoUrl,
        'id': id
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
