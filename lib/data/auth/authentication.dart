import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:yadonor/ui/auth/authentication_error_dialog.dart';
import 'package:yadonor/ui/main_screen.dart';

final GlobalKey<FormState> signUpKey = GlobalKey();
final GlobalKey<FormState> loginKey = GlobalKey();
// Map<String, String> _authData = {
//   'email': '',
//   'password': '',
// };

final FocusNode emailFocus = FocusNode();
final FocusNode passwordFocus = FocusNode();
final FocusNode confirmPasswordFocus = FocusNode();

void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();

final FirebaseAuth auth = FirebaseAuth.instance;

Future<void> submitSignUp(BuildContext context) async {
  signUpKey.currentState.save();
  print(signUpKey.toString());
  // _authData['email'] = _emailController.text;
  // _authData['password'] = _passwordController.text;

  if (!signUpKey.currentState.validate()) {
    // invalid!
    return;
  }
  print('validation succeded');

  User user;
  try {
    UserCredential authResult = await auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    user = authResult.user;
  } on FirebaseAuthException catch (error) {
    if (error.code == 'email-already-in-use') {
      print(
          'Аккаунт с таким e-mail уже существует'); //ToDo: show user error message
    }
    print('signup failed: ' + error.code);
  }
  if (user != null) {
    Navigator.of(context).pushReplacementNamed(MainScreen.routeName);

    // sign in successfully
  } else {
    authenticationErrorDialog(context);
  }

  //  ...do to submit
}

Future<void> submitLogin(BuildContext context) async {
  // _authData['email'] = _emailController.text;
  // _authData['password'] = _passwordController.text;

  if (!loginKey.currentState.validate()) {
    // invalid!
    return;
  }
  loginKey.currentState.save();
  print('validation succeded');

  UserCredential authResult;
  try {
    authResult = await auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  } catch (error) {
    print(error.code);
  }
  if (authResult != null) {
    Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
    // Provider.of<CalendarEventsProvider>(context, listen: false).fetchEvents().then((_) => print('events fetched'));
    print('fetchEvents');
  } else {
    authenticationErrorDialog(context);
  }
}
//  ...do to submit
