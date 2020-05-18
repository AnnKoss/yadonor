import 'package:flutter/material.dart';

import '../screens/precautions_screen.dart';
import '../screens/pre_questionary_screen.dart';
import '../screens/calendar_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
      BuildContext context, IconData icon, String title, routeName) {
    return Container(
      height: 60,
      // margin: EdgeInsets.symmetric(vertical: 5),
      child: FlatButton(
        onPressed: () => Navigator.of(context).pushReplacementNamed(routeName),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      icon,
                      size: 26,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 30,
              bottom: 10,
            ),
            child: Text(
              'МЕНЮ',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 2,
          ),
          buildListTile(
              context, Icons.assignment, 'Анкета донора', PreQuestionaryScreen.routeName),
          buildListTile(context, Icons.event, 'Календарь донаций', CalendarScreen.routeName),
          buildListTile(
              context, Icons.error, 'Противопоказания к донорству', PrecautionsScreen.routeName),
          // buildListTile(
          //     context, Icons.help_outline, 'Как проходит донация', TestScreen),
          // buildListTile(context, Icons.check, 'Рекомендации до и после донации',
          //     TestScreen),
          // buildListTile(context, Icons.location_on,
          //     'Адреса станций переливания крови', TestScreen),
        ],
      ),
    );
  }
}
