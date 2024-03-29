﻿import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:yadonor/main.dart';
import 'package:yadonor/ui/auth_screen/auth_screen.dart';
import 'package:yadonor/ui/main_screen/main_screen.dart';
import 'package:yadonor/ui/questionary_screen/pre_questionary_screen.dart';
import 'package:yadonor/ui/calendar_screen/calendar_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
    BuildContext context,
    IconData icon,
    String title,
    Function onPressed,
  ) {
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
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      icon,
                      size: 26,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 16),
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
            padding: const EdgeInsets.only(
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
                .pushReplacementNamed(CalendarScreen.routeName),
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
