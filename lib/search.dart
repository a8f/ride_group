import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'generated/i18n.dart';
import 'ride.dart';
import 'ride_info.dart';
import 'server.dart';
import 'util.dart';

class Search extends StatefulWidget implements AppBarPageBase {
  _SearchState createState() => _SearchState();

  @override
  AppBar getAppBar(BuildContext context) =>
      new AppBar(title: Text(S.of(context).searchAppBarTitle));
}

class _SearchState extends State<Search> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _startLocationController =
      TextEditingController();
  final TextEditingController _endLocationController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  String _maxStartDist, _maxEndDist;
  bool _advancedSearch = false;
  List<Ride> _rides = List<Ride>();
  bool _ridesLoading = false;
  Position _location;

  @override
  initState() {
    super.initState();
    getInitialLocation();
  }

  void getInitialLocation() async {
    _location = await Geolocator().getCurrentPosition();
  }

  void _submitSearch() async {
    //if (!_formKey.currentState.validate()) return;
    FocusScope.of(context).requestFocus(new FocusNode());
    final rides = await searchRides(searchQueryJson());
    debugPrint(rides[0].toString());
    setState(() => _rides = rides);
  }

  Map<String, dynamic> searchQueryJson() {
    Map<String, dynamic> queryJson = Map<String, dynamic>();
    queryJson['title'] = _titleController.text;
    queryJson['latitude'] = _location.latitude;
    queryJson['longitude'] = _location.longitude;
    if (_startLocationController.text.isNotEmpty)
      queryJson['start_loc_name'] = _startLocationController.text;
    if (_endLocationController.text.isNotEmpty)
      queryJson['end_loc_name'] = _endLocationController.text;
    if (_maxStartDist != null) queryJson['start_max_dist'] = _maxStartDist;
    if (_maxEndDist != null) queryJson['end_max_dist'] = _maxEndDist;
    return queryJson;
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
      return Center(child: Text(S.of(context).noRideSearchResults));
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
  Widget build(BuildContext context) {
    return Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Expanded(
            child: Card(
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          Expanded(
                              child: TextFormField(
                                  controller: _titleController,
                                  decoration: InputDecoration(
                                      hintText: S.of(context).searchTitleHint),
                                  validator: (v) => v.length > 2
                                      ? null
                                      : S
                                          .of(context)
                                          .searchTitleValidationFail))
                        ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                  child: DropdownButtonFormField(
                                      items: metricDistancesDropdownItems,
                                      onChanged: (v) =>
                                          setState(() => _maxStartDist = v),
                                      value: _maxStartDist,
                                      hint: Text(
                                          S.of(context).searchMaxStartDist))),
                              Expanded(
                                  child: DropdownButtonFormField(
                                      items: metricDistancesDropdownItems,
                                      onChanged: (v) =>
                                          setState(() => _maxEndDist = v),
                                      value: _maxEndDist,
                                      hint:
                                          Text(S.of(context).searchMaxEndDist)))
                            ]),
                        Visibility(
                            visible: _advancedSearch,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: TextFormField(
                                  controller: _startLocationController,
                                  decoration: InputDecoration(
                                      hintText: S.of(context).searchStartHint),
                                )),
                                Expanded(
                                    child: TextFormField(
                                  controller: _endLocationController,
                                  decoration: InputDecoration(
                                      hintText: S.of(context).searchEndHint),
                                ))
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            MaterialButton(
                              color: Theme.of(context).buttonColor,
                              child: Text(S.of(context).searchAdvanced),
                              onPressed: () => setState(
                                  () => _advancedSearch = !_advancedSearch),
                            ),
                            MaterialButton(
                              color: Theme.of(context).buttonColor,
                              child: Text(S.of(context).searchSubmit),
                              onPressed: _submitSearch,
                            )
                          ],
                        )
                      ],
                    )))),
      ]),
      Expanded(child: _rideListView(context))
    ]));
  }
}
