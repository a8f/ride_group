import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'util.dart';
import 'server.dart';
import 'apikeys.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'create_vehicle.dart';

class CreateRide extends StatefulWidget {
  _CreateRideState createState() => _CreateRideState();
}

class _CreateRideState extends State<CreateRide> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _startLocationTextController = TextEditingController();
  final _endLocationTextController = TextEditingController();
  final _descriptionController = TextEditingController();
  LocationResult _startLocation, _endLocation;
  Vehicle _selectedVehicle;

  @override
  void initState() {
    // Make sure we have location permissions here since there are bugs in
    // google_map_location_picker's handling of it
    promptForLocationPermission();
    getVehicles();
    super.initState();
  }

  // Get the user's vehicles then rerun build
  void getVehicles() async {
    await getUserVehicles(user);
    setState(() {});
  }

  List<DropdownMenuItem<Vehicle>> _vehicleDropdownMenuItems(
      BuildContext context) {
    List<DropdownMenuItem<Vehicle>> vehicleDropdownItems;
    if (user.vehicles == null) {
      vehicleDropdownItems = List<DropdownMenuItem<Vehicle>>();
    } else {
      vehicleDropdownItems =
          user.vehicles.map<DropdownMenuItem<Vehicle>>((Vehicle v) {
        return DropdownMenuItem<Vehicle>(
          value: v,
          child: Text(S
              .of(context)
              .vehicleFriendlyName(v.name, v.color, v.make, v.model)),
        );
      }).toList();
    }
    vehicleDropdownItems.insert(
        0,
        DropdownMenuItem<Vehicle>(
            value: null, child: Text(S.of(context).newVehicle)));
    return vehicleDropdownItems;
  }

  void promptForLocationPermission() async {
    final GeolocationStatus permission =
        await Geolocator().checkGeolocationPermissionStatus();
    switch (permission) {
      case GeolocationStatus.granted:
        return;
      case GeolocationStatus.unknown:
        // Try to get position, which will prompt for location permissions
        final Position pos = await Geolocator().getCurrentPosition();
        break;
      case GeolocationStatus.disabled:
        return;
      default:
        debugPrint('Denied permissions');
        return;
    }
  }

  void createRide() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: FORM_PADDING,
            child: Center(
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                              controller: _titleController,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  labelText: S.of(context).rideTitleLabel)),
                          TextFormField(
                              controller: _descriptionController,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  labelText:
                                      S.of(context).rideDescriptionLabel)),
                          GestureDetector(
                              onTap: () async {
                                _startLocation =
                                    await LocationPicker.pickLocation(
                                        context, MAPS_API_KEY);
                                _startLocationTextController.text =
                                    _startLocation.address ??
                                        _startLocation.latLng.toString();
                              },
                              behavior: HitTestBehavior.opaque,
                              child: TextFormField(
                                  controller: _startLocationTextController,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText:
                                          S.of(context).selectStartLocation))),
                          GestureDetector(
                              onTap: () async {
                                _endLocation =
                                    await LocationPicker.pickLocation(
                                        context, MAPS_API_KEY);
                                _endLocationTextController.text =
                                    _endLocation.address ??
                                        _endLocation.latLng.toString();
                              },
                              behavior: HitTestBehavior.opaque,
                              child: TextFormField(
                                  controller: _endLocationTextController,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText:
                                          S.of(context).selectEndLocation))),
                          DropdownButton<Vehicle>(
                              value: _selectedVehicle,
                              hint: Text(S.of(context).vehicleSelect),
                              onChanged: (Vehicle v) {
                                if (v == null) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CreateVehicle()));
                                  return;
                                }
                                setState(() {
                                  _selectedVehicle = v;
                                });
                              },
                              items: _vehicleDropdownMenuItems(context)),
                          Padding(
                              padding: SUBMIT_BUTTON_PADDING,
                              child: Center(
                                  child: MaterialButton(
                                      child: Text(S.of(context).createRide),
                                      onPressed: createRide)))
                        ])))),
        appBar: AppBar());
  }
}
