import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'generated/i18n.dart';
import 'server.dart';
import 'util.dart';

class Account extends StatelessWidget implements AppBarPageBase {
  @override
  Widget build(BuildContext context) {
    // TODO
    return Container(
      padding: PROFILE_PADDING,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                  visible: user.photoUrl.isNotEmpty,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Image.network(user.photoUrl))),
              Text('${user.fullName()} (${user.username})')
            ],
          ),
          Visibility(
              visible: user.ridesPassenger > 0 && user.passengerRating >= 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RatingBarIndicator(
                    rating: user.passengerRating,
                    itemBuilder: (context, _) =>
                        Icon(Icons.star, color: Theme.of(context).accentColor),
                  ),
                  Text(
                      S.of(context).averagePassengerRating(user.ridesPassenger))
                ],
              )),
          Visibility(
              visible: user.ridesDriver > 0 && user.driverRating >= 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RatingBarIndicator(
                    rating: user.driverRating,
                    itemBuilder: (context, _) =>
                        Icon(Icons.star, color: Theme.of(context).accentColor),
                  ),
                  Text(S.of(context).averageDriverRating(user.ridesDriver))
                ],
              )),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: MaterialButton(
                  color: Theme.of(context).buttonColor,
                  onPressed: null,
                  child: Text(S.of(context).editProfile)))
        ],
      ),
    );
  }

  @override
  AppBar getAppBar(BuildContext context) =>
      new AppBar(title: Text(user.fullName()));
}
