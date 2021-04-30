import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final BuildContext context;
  final void Function() onPressed;
  final String buttonText;

  Button({
    this.context,
    this.onPressed,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 55,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textColor: Colors.white,
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Colors.black26),
        ),
      ),
    );
  }
}
