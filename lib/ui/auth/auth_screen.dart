// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'package:yadonor/ui/auth/auth_screen_wm.dart';
import 'package:yadonor/ui/auth/widgets/signup/signup_form.dart';
import 'package:yadonor/ui/auth/widgets/login/login_form.dart';
import 'package:yadonor/ui/common/button.dart';

class AuthScreen extends CoreMwwmWidget {
  AuthScreen()
      : super(
          widgetModelBuilder: (context) =>
              AuthWidgetModel.buildAuthScreenWM(context),
        );
  @override
  State<StatefulWidget> createState() => _AuthScreenState();

  static const routeName = '/auth';
}

class _AuthScreenState extends WidgetState<AuthWidgetModel> {
  final GlobalKey<FormState> signUpKey = GlobalKey();
  final GlobalKey<FormState> loginKey = GlobalKey();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

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
          child: StreamedStateBuilder<bool>(
            streamedState: wm.isLoading,
            builder: (context, isLoading) {
              return (isLoading)
                  ? CircularProgressIndicator()
                  : SingleChildScrollView(
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'РЕГИСТРАЦИЯ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
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
                                      LogInForm(
                                        loginKey,
                                        wm.emailController,
                                        wm.passwordController,
                                        emailFocus,
                                        passwordFocus,
                                      ),
                                      SizedBox(height: 20),
                                      button(
                                        context: context,
                                        buttonText: 'Войти',
                                        onPressed: () => wm.submitLoginAction(),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      SizedBox(height: 30),
                                      SignUpForm(
                                        signUpKey,
                                        wm.emailController,
                                        wm.passwordController,
                                        wm.confirmPasswordController,
                                        emailFocus,
                                        passwordFocus,
                                        confirmPasswordFocus,
                                      ),
                                      SizedBox(height: 20),
                                      button(
                                        context: context,
                                        buttonText: 'Зарегистрироваться',
                                        onPressed: () =>
                                            wm.submitSignUpAction(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
