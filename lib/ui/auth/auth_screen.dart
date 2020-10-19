import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yadonor/data/auth/signup_form.dart';

import 'package:yadonor/ui/main_screen.dart';
import 'package:yadonor/data/auth/authentication.dart';
import 'package:yadonor/ui/button.dart';
import 'package:yadonor/data/auth/login_form.dart';

// enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xff00d4ff), const Color(0xff00608a)],
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TabBar(
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          'ВХОД',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'РЕГИСТРАЦИЯ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Column(
                          children: <Widget>[
                            SizedBox(height: 30),
                            LogInForm(),
                            SizedBox(height: 20),
                            button(
                              context: context,
                              buttonText: 'Войти',
                              onPressed: () => submitLogin(context),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(height: 30),
                            SignUpForm(),
                            SizedBox(height: 20),
                            button(
                              context: context,
                              buttonText: 'Зарегистрироваться',
                              onPressed: () => submitSignUp(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}