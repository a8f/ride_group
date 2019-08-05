class User {
  String username;
  String email;

  User(this.username, this.email);

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
      };
}
