import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'generated/i18n.dart';
import 'server.dart';
import 'util.dart';
import 'ride.dart';
import 'vehicle.dart';
import 'ride_info.dart';

class MyRides extends StatefulWidget implements AppBarPageBase {
  _MyRidesState createState() => _MyRidesState();

  @override
  AppBar getAppBar(BuildContext context) =>
      new AppBar(title: Text(S.of(context).ridesAppBarTitle(user.firstName)));
}

class _MyRidesState extends State<MyRides> {
  final ScrollController _scrollController = ScrollController();
  bool _ridesLoading = true;
  List<Ride> _rides = List<Ride>();

  _MyRidesState() {
    loadUserRides();
  }

  void loadUserRides() async {
    _rides = await currentUserRides().catchError((error) {
      // TODO
      debugPrint(error);
      return;
    });
    _ridesLoading = false;
    setState(() {});
  }

  Widget _rideListView(BuildContext context) {
    if (_rides.length == 0) {
      if (_ridesLoading) {
        return Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Visibility(
                visible: _ridesLoading,
                child: SpinKitRing(color: Theme.of(context).accentColor)));
      }
      return Text(S.of(context).myRidesEmpty);
    }
    final DateFormat dateFormat =
        DateFormat.yMMMd(Localizations.localeOf(context).languageCode);
    final DateFormat timeFormat =
        DateFormat.Hms(Localizations.localeOf(context).languageCode);
    return ListView.separated(
      controller: _scrollController,
      itemCount: _rides.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_rides[index].title),
          subtitle: Text(S.of(context).rideTimeInfo(
              dateFormat.format(_rides[index].time),
              timeFormat.format(_rides[index].time))),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RideInfo(ride: _rides[index])));
          },
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  @override
  Widget build(BuildContext context) => _rideListView(context);
}
