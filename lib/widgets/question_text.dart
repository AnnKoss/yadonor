import 'package:flutter/material.dart';

class QuestionText extends StatelessWidget {
  final String questionText;

  QuestionText(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // padding: EdgeInsets.all(20),
        // margin: EdgeInsets.symmetric(vertical: 20),
        // child: Align(
          // alignment: Alignment.topLeft,
          child: Text(
            questionText,
            style: TextStyle(fontSize: 20),
          ),
        // ),
      ),
    );
  }
}
