import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'apikeys.dart';
import 'create_vehicle.dart';
import 'generated/i18n.dart';
import 'ride.dart';
import 'server.dart';
import 'util.dart';
import 'vehicle.dart';

class CreateRide extends StatefulWidget {
  _CreateRideState createState() => _CreateRideState();
}

class _CreateRideState extends State<CreateRide> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _startLocationTextController = TextEditingController();
  final _endLocationTextController = TextEditingController();
  final _descriptionController = TextEditingController();
  Place _startLocation, _endLocation;
  Vehicle _selectedVehicle;
  DateTime _selectedDateTime;
  LatLng _initialLocation;

  @override
  void initState() {
    getInitialLocation();
    super.initState();
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
          child: Text(S.of(context).vehicleFriendlyName(v.name, v.plate)),
        );
      }).toList();
    }
    vehicleDropdownItems.insert(
        0,
        DropdownMenuItem<Vehicle>(
            value:
                Vehicle(null, null, null, null, null, null, null, null, null),
            child: Text(S.of(context).newVehicle)));
    return vehicleDropdownItems;
  }

  void createRideAndGoBack(BuildContext context, Ride ride) async {
    ride = await createRide(ride);
    if (ride.id != null) {
      Navigator.of(context).pop(ride);
    }
  }

  void getInitialLocation() async {
    final initialPosition = await Geolocator().getCurrentPosition();
    _initialLocation =
        LatLng(initialPosition.latitude, initialPosition.longitude);
  }

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
                                _startLocation = Place.fromLocationResult(
                                    await LocationPicker.pickLocation(
                                        context, MAPS_API_KEY,
                                        initialCenter: _initialLocation));
                                _startLocationTextController.text =
                                    _startLocation.toString();
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
                                _endLocation = Place.fromLocationResult(
                                    await LocationPicker.pickLocation(
                                        context, MAPS_API_KEY,
                                        initialCenter: _initialLocation));
                                _endLocationTextController.text =
                                    _endLocation.toString();
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
                              onChanged: (Vehicle v) {
                                if (v.id == null) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CreateVehicle()));
                                  return;
                                }
                                setState(() {
                                  _selectedVehicle = v;
                                });
                              },
                              isExpanded: false,
                              items: _vehicleDropdownMenuItems(context),
                              hint: Text(S.of(context).vehicleSelect)),
                          DateTimeField(
                              decoration: InputDecoration(
                                  labelText: S.of(context).rideTimeLabel),
                              format: defaultDateFormat,
                              onShowPicker: (context, currentValue) async {
                                DateTime date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate:
                                        DateTime(DateTime.now().year + 1));
                                TimeOfDay time = await showTimePicker(
                                    context: context,
                                    initialTime:
                                        TimeOfDay.fromDateTime(DateTime.now()));
                                DateTime selected = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    time.hour,
                                    time.minute);
                                setState(() {
                                  _selectedDateTime = selected;
                                });
                                return selected;
                              }),
                          Padding(
                              padding: SUBMIT_BUTTON_PADDING,
                              child: Center(
                                  child: MaterialButton(
                                      color: Theme.of(context).buttonColor,
                                      child: Text(S.of(context).createRide),
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          Ride newRide = Ride(
                                              _selectedVehicle,
                                              user,
                                              _titleController.value.text,
                                              _descriptionController.value.text,
                                              _startLocation,
                                              _endLocation,
                                              _selectedDateTime);
                                          createRideAndGoBack(context, newRide);
                                        }
                                      })))
                        ])))),
        appBar: AppBar());
  }
}
