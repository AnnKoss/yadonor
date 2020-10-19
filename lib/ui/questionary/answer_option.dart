import 'package:flutter/material.dart';

import 'package:yadonor/ui/button.dart';

class AnswerOption extends StatelessWidget {
  final String answerText;
  final Function onClick;
  final int order;

  AnswerOption(this.answerText, this.onClick, this.order);

  @override
  Widget build(BuildContext context) {
    return button(
      context: context,
      onPressed: () => onClick(order),
      buttonText: answerText,
    );
  }
}
