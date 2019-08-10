import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'base_app.dart';
import 'generated/i18n.dart';
import 'server.dart';

class Register extends StatelessWidget {
  Register({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).registrationTitle)),
      body: RegistrationForm(),
    );
  }
}

const EdgeInsets FORM_PADDING =
    EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0);
const EdgeInsets SUBMIT_BUTTON_PADDING = EdgeInsets.symmetric(vertical: 16.0);
final lettersAndNumbersRegex = RegExp(r'^[\da-zA-Z_]+$');
final lettersRegex = RegExp(r'^[A-Za-z]+$');

class RegistrationForm extends StatefulWidget {
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final firstNameController = TextEditingController();
  final firstNameFocusNode = FocusNode();
  final lastNameController = TextEditingController();
  final lastNameFocusNode = FocusNode();
  final phoneController = TextEditingController();
  final phoneFocusNode = FocusNode();

  @override
  initState() {
    super.initState();
    usernameController.text = Server.user.username;
    emailController.text = Server.user.email;
    firstNameController.text = Server.user.firstName;
    lastNameController.text = Server.user.lastName;
    phoneController.text = Server.user.phone;
  }

  register() async {
    // Hide keyboard
    FocusScope.of(context).requestFocus(new FocusNode());
    if (formKey.currentState.validate()) {
      Server.user.username = usernameController.text;
      Server.user.email = emailController.text;
      Server.user.firstName = firstNameController.text;
      Server.user.lastName = lastNameController.text;
      if (phoneController.text.isNotEmpty)
        Server.user.phone = phoneController.text;
      if (!await Server.registerUser()) {
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
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                        textCapitalization: TextCapitalization.none,
                        controller: usernameController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: Server.user.username,
                            labelText: S.of(context).usernameLabel),
                        onFieldSubmitted: (x) =>
                            FocusScope.of(context).requestFocus(emailFocusNode),
                        validator: (val) => (val.length > 3 &&
                                lettersAndNumbersRegex.hasMatch(val))
                            ? null
                            : S.of(context).usernameRequirements),
                    TextFormField(
                        textCapitalization: TextCapitalization.none,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: S.of(context).emailLabel),
                        onFieldSubmitted: (x) => FocusScope.of(context)
                            .requestFocus(firstNameFocusNode),
                        validator: (val) => EmailValidator.validate(val)
                            ? null
                            : S.of(context).invalidEmail),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              controller: firstNameController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: S.of(context).firstNameLabel),
                              onFieldSubmitted: (x) => FocusScope.of(context)
                                  .requestFocus(lastNameFocusNode),
                              validator: (val) => lettersRegex.hasMatch(val)
                                  ? null
                                  : S.of(context).invalidName),
                        ),
                        Spacer(flex: 1),
                        Expanded(
                          child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              controller: lastNameController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: S.of(context).lastNameLabel),
                              onFieldSubmitted: (x) => FocusScope.of(context)
                                  .requestFocus(lastNameFocusNode),
                              validator: (val) => lettersRegex.hasMatch(val)
                                  ? null
                                  : S.of(context).invalidName),
                        )
                      ],
                    ),
                    TextFormField(
                        controller: phoneController,
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
                          color: Theme.of(context).backgroundColor,
                          onPressed: register,
                        )))
                  ],
                ))));
  }
}
