import 'package:flutter/material.dart';

import 'package:yadonor/ui/questionary/questionary_screen.dart';
import 'package:yadonor/ui/button.dart';
import 'package:yadonor/ui/main_drawer.dart';

class PreQuestionaryScreen extends StatelessWidget {
  static const routeName = '/pre-questionary';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'АНКЕТА ДОНОРА',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      drawer: MainDrawer(),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  .pushNamed(QuestionaryScreen.routeName),
              buttonText: 'НАЧАТЬ ОПРОС',
            ),
          ],
        ),
      ),
    );
  }
}
