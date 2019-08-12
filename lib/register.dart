import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'base_app.dart';
import 'generated/i18n.dart';
import 'server.dart';
import 'util.dart';

class Register extends StatelessWidget {
  Register({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).registrationTitle)),
      body: _RegistrationForm(),
    );
  }
}

final lettersAndNumbersRegex = RegExp(r'^[\da-zA-Z_]+$');
final lettersRegex = RegExp(r'^[A-Za-z]+$');

class _RegistrationForm extends StatefulWidget {
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<_RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _firstNameController = TextEditingController();
  final _firstNameFocusNode = FocusNode();
  final _lastNameController = TextEditingController();
  final _lastNameFocusNode = FocusNode();
  final _phoneController = TextEditingController();
  final _phoneFocusNode = FocusNode();

  @override
  initState() {
    super.initState();
    _usernameController.text = user.username;
    _emailController.text = user.email;
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _phoneController.text = user.phone;
  }

  void register() async {
    // Hide keyboard
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState.validate()) {
      user.username = _usernameController.text;
      user.email = _emailController.text;
      user.firstName = _firstNameController.text;
      user.lastName = _lastNameController.text;
      if (_phoneController.text.isNotEmpty) user.phone = _phoneController.text;
      if (!await registerUser()) {
        // TODO
        return;
      }
      Navigator.popUntil(
          context, ModalRoute.withName(Navigator.defaultRouteName));
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return BaseApp();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: FORM_PADDING,
        child: Center(
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                        textCapitalization: TextCapitalization.none,
                        controller: _usernameController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: user.username,
                            labelText: S.of(context).usernameLabel),
                        onFieldSubmitted: (x) => FocusScope.of(context)
                            .requestFocus(_emailFocusNode),
                        validator: (val) => (val.length > 3 &&
                                lettersAndNumbersRegex.hasMatch(val))
                            ? null
                            : S.of(context).usernameRequirements),
                    TextFormField(
                        textCapitalization: TextCapitalization.none,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: S.of(context).emailLabel),
                        onFieldSubmitted: (x) => FocusScope.of(context)
                            .requestFocus(_firstNameFocusNode),
                        validator: (val) => EmailValidator.validate(val)
                            ? null
                            : S.of(context).invalidEmail),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              controller: _firstNameController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: S.of(context).firstNameLabel),
                              onFieldSubmitted: (x) => FocusScope.of(context)
                                  .requestFocus(_lastNameFocusNode),
                              validator: (val) => lettersRegex.hasMatch(val)
                                  ? null
                                  : S.of(context).invalidName),
                        ),
                        Spacer(flex: 1),
                        Expanded(
                          child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              controller: _lastNameController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: S.of(context).lastNameLabel),
                              onFieldSubmitted: (x) => FocusScope.of(context)
                                  .requestFocus(_lastNameFocusNode),
                              validator: (val) => lettersRegex.hasMatch(val)
                                  ? null
                                  : S.of(context).invalidName),
                        )
                      ],
                    ),
                    TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                            labelText: S.of(context).phoneLabel),
                        onFieldSubmitted: (x) => register(),
                        validator: (val) =>
                            RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(val)
                                ? null
                                : S.of(context).invalidPhone),
                    Padding(
                        padding: SUBMIT_BUTTON_PADDING,
                        child: Center(
                            child: MaterialButton(
                          child: Text(S.of(context).submitRegistration),
                          onPressed: register,
                        )))
                  ],
                ))));
  }
}
