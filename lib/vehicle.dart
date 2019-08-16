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
