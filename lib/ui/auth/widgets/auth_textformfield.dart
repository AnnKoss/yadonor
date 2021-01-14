import 'package:flutter/material.dart';

Widget authTextFormField(TextFormField textFormField) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    // height: 60,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    child: textFormField,
  );
}

void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}