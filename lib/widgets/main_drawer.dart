import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:yadonor/main.dart';
import 'package:yadonor/screens/auth_screen.dart';
import 'package:yadonor/screens/main_screen.dart';
import 'package:yadonor/screens/address_screen.dart';
import 'package:yadonor/screens/precautions_screen.dart';
import 'package:yadonor/screens/pre_questionary_screen.dart';
import 'package:yadonor/screens/calendar_screen_view.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
      BuildContext context, IconData icon, String title, Function onPressed) {
    return Container(
      height: 60,
      child: FlatButton(
        onPressed: onPressed,
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
    Future<void> signOut() async {
      await FirebaseAuth.instance.signOut();
      runApp(MyApp());
    }

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
            context,
            Icons.home,
            'На главную',
            () => Navigator.of(context)
                .pushReplacementNamed(MainScreen.routeName),
          ),
          buildListTile(
            context,
            Icons.assignment,
            'Анкета донора',
            () => Navigator.of(context)
                .pushReplacementNamed(PreQuestionaryScreen.routeName),
          ),
          buildListTile(
            context,
            Icons.event,
            'Календарь донаций',
            () => Navigator.of(context)
                .pushReplacementNamed(CalendarScreenView.routeName),
          ),
          buildListTile(
            context,
            Icons.error,
            'Противопоказания к донорству',
            () => Navigator.of(context)
                .pushReplacementNamed(PrecautionsScreen.routeName),
          ),
          buildListTile(
            context,
            Icons.location_on,
            'Адреса станций переливания крови',
            () => Navigator.of(context)
                .pushReplacementNamed(AddressScreen.routeName),
          ),
          buildListTile(
            context,
            Icons.exit_to_app,
            'Выход',
            () {
              signOut();
              Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
