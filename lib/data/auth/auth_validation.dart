import 'package:flutter/material.dart';

String emailValidator(String value) {
  Pattern pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  return (!RegExp(pattern).hasMatch(value)) ? 'Invalid email' : null;
}

String passwordValidator(String value) {
  return (value.isEmpty || value.length < 6) ? 'Invalid Password' : null;
}

String confirmPasswordValidator(String value, TextEditingController passwordController) {
  return (value != passwordController.text) ? 'Пароль введен неверно' : null;
}
