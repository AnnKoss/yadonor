import 'package:flutter/material.dart';

import './questionary_screen.dart';

import '../widgets/button.dart';
import '../widgets/main_drawer.dart';

class PreQuestionaryScreen extends StatelessWidget {
  static const routeName = '/pre-questionary';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'АНКЕТА ДОНОРА',
          style: Theme.of(context).textTheme.title,
        ),
      ),
      drawer: MainDrawer(),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.body1,
                children: [
                  TextSpan(
                    text: 'Стать донором может только здоровый человек.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '\n\nС помощью нашей интерактивной анкеты проверьте свое здоровье и узнайте, сможете ли Вы стать донором крови. Обратите внимание,что окончательное решение о допуске человека к донорству крови принимает врач-трансфузиолог учреждения Службы крови.\n'),
                ],
              ),
            ),
            button(
              context: context,
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(QuestionaryScreen.routeName),
              buttonText: 'Начать опрос',
            ),
          ],
        ),
      ),
    );
  }
}
