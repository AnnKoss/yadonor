import 'package:flutter/material.dart';

Widget button({
  BuildContext context,
  void Function() onPressed,
  String buttonText,
}) {
  return Container(
    width: 300,
    height: 55,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    child: RaisedButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textColor: Colors.white,
      color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
  );
}
