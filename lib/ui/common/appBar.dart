import 'package:flutter/material.dart';

class AppBarTitile extends StatelessWidget {
  final String text;
  AppBarTitile(this.text);
  
  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
