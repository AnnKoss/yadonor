import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';

/// Component for auth_screen
class AuthComponent implements Component {
  AuthComponent(
    this.navigator,
  );

  final NavigatorState navigator;
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
}