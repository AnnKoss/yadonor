import 'package:flutter/material.dart';

class QuestionText extends StatelessWidget {
  final String questionText;

  QuestionText(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Text(
          questionText,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
