import 'package:flutter/material.dart';

import 'package:yadonor/data/dictionaries/question_list.dart';
import 'package:yadonor/domain/questionary-item.dart';
import 'package:yadonor/ui/common/appBar.dart';
import 'package:yadonor/ui/questionary_screen/questionary_result_screen.dart';
import 'package:yadonor/ui/questionary_screen/answer_option.dart';
import 'package:yadonor/ui/questionary_screen/question_text.dart';
import 'package:yadonor/ui/common/main_drawer.dart';

class QuestionaryScreen extends StatefulWidget {
  static const routeName = '/questionary';

  @override
  _QuestionaryScreenState createState() => _QuestionaryScreenState();
}

class _QuestionaryScreenState extends State<QuestionaryScreen> {
  var questionIndex = 0;

  void onClick(int order) {
    AnswerResult result = questionList[questionIndex].onChoose(order);
    if ((result == AnswerResult.next) &&
        (questionIndex < (questionList.length - 1))) {
      setState(
        () {
          questionIndex++;
        },
      );
    } else if (result == AnswerResult.fail) {
      Navigator.of(context).pushReplacementNamed(
        QuestionaryResultScreen.routeName,
        arguments: {
          'success': 'false',
          'failText': questionList[questionIndex].failText,
        },
      );
      setState(
        () {
          questionIndex = 0;
        },
      );
    } else if ((result == AnswerResult.next) &&
        (questionIndex == (questionList.length - 1))) {
      Navigator.of(context).pushReplacementNamed(
        QuestionaryResultScreen.routeName,
        arguments: {
          'success': 'true',
          'failText': '',
        },
      );
      setState(
        () {
          questionIndex = 0;
        },
      );
    } else if (result == AnswerResult.skip) {
      setState(
        () {
          questionIndex += 3;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitile(
          'анкета донора',
        ),
        actions: <Widget>[
          BackButton(
            onPressed: () {
              (questionIndex > 0)
                  ? setState(
                      () {
                        questionIndex -= 1;
                      },
                    )
                  : Navigator.of(context).pop();
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QuestionText(questionList[questionIndex].questionText),
            AnswerOption(questionList[questionIndex].answer1, onClick, 0),
            AnswerOption(questionList[questionIndex].answer2, onClick, 1),
          ],
        ),
      ),
    );
  }
}
