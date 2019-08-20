import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

const EdgeInsets FORM_PADDING =
    EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0);
const EdgeInsets SUBMIT_BUTTON_PADDING = EdgeInsets.symmetric(vertical: 16.0);
const EMPTY_JSON_RESPONSE = '""';
DateFormat defaultDateFormat = DateFormat();

const List<String> metricDistances = ["100m", "250m", "500m", "1km", "5km"];
const List<String> imperialDistances = [
  "100yd",
  "250yd",
  "500yd",
  "1mi",
  "5mi"
];

final List<DropdownMenuItem> metricDistancesDropdownItems = metricDistances
    .map((dist) => DropdownMenuItem<String>(value: dist, child: Text(dist)))
    .toList();

final List<DropdownMenuItem> imperialDistancesDropdownItems = metricDistances
    .map((dist) => DropdownMenuItem<String>(value: dist, child: Text(dist)))
    .toList();

abstract class AppBarPageBase {
  AppBar getAppBar(BuildContext context);
}

class Place {
  LatLng latLng;
  String name;

  Place(this.name, this.latLng);

  Place.fromLatLng(String name, double latitude, double longitude) {
    this.name = name;
    latLng = LatLng(latitude, longitude);
  }

  Place.fromLocationResult(LocationResult locationResult) {
    name = locationResult.address;
    latLng = locationResult.latLng;
  }

  toString() => name ?? '${latLng.latitude}, ${latLng.longitude}';
}
