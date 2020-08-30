import 'package:flutter/material.dart';

Widget mainScreenButton({
  void Function() onPressed,
  String buttonText,
}) {
  return Container(
    width: 300,
    height: 55,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    child: 
    RaisedButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textColor: Colors.white,
      color: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide(color: Colors.white)),
    ),
  );
}
