import 'dart:io';
import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class AdressScreen extends StatefulWidget {
  static const routeName = '/adress';
  @override
  _AdressScreenState createState() => _AdressScreenState();
}

class _AdressScreenState extends State<AdressScreen> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MainDrawer(),
      body: Container(),
    );
  }
}
