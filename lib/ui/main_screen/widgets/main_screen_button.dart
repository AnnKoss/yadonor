import 'package:flutter/material.dart';

class MainScreenButton extends StatelessWidget {
  final void Function() onPressed;
  final String buttonText;
  MainScreenButton({
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
        color: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
