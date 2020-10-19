import 'package:flutter/material.dart';

import 'package:yadonor/ui/button.dart';
import 'package:yadonor/ui/main_drawer.dart';

class QuestionaryResultScreen extends StatelessWidget {
  static const routeName = '/questionary-result';

  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    final Text failText = Text(
      routeArguments['failText'],
      style: TextStyle(fontSize: 20),
    );
    
    final success = routeArguments['success'];
    final RichText successText = RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.headline1,
        children: [
          TextSpan(
            text: 'Вы сможете стать донором уже завтра.',
            style: TextStyle(fontSize: 20),
          ),
          TextSpan(
            text:
                '\n\nОбратите внимание, что конечное решение о допуске к процедуре принимает врач-трансфузиолог.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );

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
            (success == 'true') ? successText : failText,
            SizedBox(height: 30),
            button(
              context: context,
              onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
              buttonText: 'На главную',
            ),
          ],
        ),
      ),
    );
  }
}
