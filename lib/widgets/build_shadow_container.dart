import 'package:flutter/material.dart';

Widget buildShadowContainer({Widget child}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 15),
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.black12),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          spreadRadius: 3,
          blurRadius: 5,
        )
      ],
    ),
    child: child,
  );
}
