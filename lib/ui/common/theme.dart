import 'package:flutter/material.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    primaryColor: const Color(0xff00608a),
    accentColor: const Color(0xffe9392c),
    scaffoldBackgroundColor: const Color(0xfff9fafc),
    fontFamily: 'PTSans',
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(fontSize: 18),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Theme.of(context).accentColor,
    ),
    dividerColor: Theme.of(context).primaryColor,
  );
}
