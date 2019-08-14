import 'package:flutter/material.dart';

import 'generated/i18n.dart';
import 'server.dart';
import 'util.dart';
import 'package:intl/intl.dart';

class RideInfo extends StatelessWidget {
  final Ride ride;

  RideInfo({
    Key key,
    @required this.ride,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    // TODO
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(s.driverNameLabel(ride.driver.fullName())),
          Text(s.startLocationLabel(ride.start.toString())),
          Text(s.endLocationLabel(ride.end.toString())),
          Text(s.departureTimeLabel(DateFormat().format(ride.time))),
          Text(s.rideVehicleInfo(ride.vehicle.color, ride.vehicle.year,
              ride.vehicle.make, ride.vehicle.model, ride.vehicle.plate))
        ],
      ),
    );
  }
}
