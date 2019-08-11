import 'package:flutter/material.dart';

import 'generated/i18n.dart';
import 'server.dart';
import 'util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocation extends StatefulWidget {
  SelectLocationState createState() => SelectLocationState();
}

class SelectLocationState extends State<SelectLocation> {
  static final CameraPosition _testPos = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    // TODO
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(mapType: MapType.hybrid, initialCameraPosition: _testPos),
    );
  }
}
