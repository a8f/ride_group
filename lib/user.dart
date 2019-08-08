class User {
  String username;
  String email;
  String firstName, lastName;
  DateTime dateJoined, lastLogin;
  String phone;
  String photoUrl;

  User(this.username, this.email, this.firstName, this.lastName,
      this.dateJoined, this.lastLogin, this.phone, this.photoUrl);

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
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'date_joined': dateJoined.toIso8601String(),
        'phone': phone,
        'photoUrl': photoUrl
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
