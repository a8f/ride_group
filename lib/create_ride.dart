import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'util.dart';
import 'select_location.dart';

class CreateRide extends StatefulWidget {
  CreateRideState createState() => CreateRideState();
}

class CreateRideState extends State<CreateRide> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final startLocationTextController = TextEditingController();
  final endLocationTextcontroller = TextEditingController();

  void createRide() async {}

  void selectStartLocation(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SelectLocation()));
  }

  void selectEndLocation(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    // TODO
    return Scaffold(
        body: Padding(
            padding: FORM_PADDING,
            child: Center(
                child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                              controller: titleController,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  labelText:
                                      S.of(context).rideDescriptionLabel)),
                          GestureDetector(
                              onTap: () => selectStartLocation(context),
                              behavior: HitTestBehavior.opaque,
                              child: TextFormField(
                                controller: startLocationTextController,
                                enabled: false,
                              )),
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
