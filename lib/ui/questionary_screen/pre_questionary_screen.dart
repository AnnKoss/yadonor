﻿import 'package:flutter/material.dart';
import 'package:yadonor/ui/common/appBar.dart';

import 'package:yadonor/ui/questionary_screen/questionary_screen.dart';
import 'package:yadonor/ui/common/button.dart';
import 'package:yadonor/ui/common/main_drawer.dart';

class PreQuestionaryScreen extends StatelessWidget {
  static const routeName = '/pre-questionary';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitile(
          'анкета донора',
        ),
      ),
      drawer: MainDrawer(),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.body1,
                children: [
                  const TextSpan(
                    text: 'Стать донором может только здоровый человек.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text:
                        '\n\nС помощью нашей интерактивной анкеты проверьте свое здоровье и узнайте, сможете ли Вы стать донором крови. Обратите внимание,что окончательное решение о допуске человека к донорству крови принимает врач-трансфузиолог учреждения Службы крови.\n',
                  ),
                ],
              ),
            ),
            Button(
              context: context,
              onPressed: () =>
                  Navigator.of(context).pushNamed(QuestionaryScreen.routeName),
              buttonText: 'НАЧАТЬ ОПРОС',
            ),
          ],
        ),
      ),
    );
  }
}
