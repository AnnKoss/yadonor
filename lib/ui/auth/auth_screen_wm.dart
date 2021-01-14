import 'package:flutter/material.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:yadonor/ui/main_screen/main_screen.dart';
import 'package:yadonor/model/auth/changes.dart';

/// WidgetModel for auth_screen
class AuthWidgetModel extends WidgetModel {
  final isLoading = StreamedState<bool>(false);

  AuthWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
  ) : super(dependencies);

  final NavigatorState navigator;
  Action submitLoginAction = Action<void>();
  Action submitSignUpAction = Action<void>();

  @override
  void onBind() {
    super.onBind();

    subscribe(
      submitLoginAction.stream,
      (_) {
        doFuture<bool>(
          _login(),
          (isLogin) {
            if (isLogin) {
              navigator.pushReplacementNamed(MainScreen.routeName);
            }
          },
          // onError: handleError,
        );
      },
    );

    subscribe(
      submitLoginAction.stream,
      (_) {
        doFuture<bool>(
          _signUp(),
          (isSignUp) {
            if (isSignUp) {
              navigator.pushReplacementNamed(MainScreen.routeName);
            }
          },
          // onError: handleError,
        );
      },
    );
  }

  Future<bool> _login() {
    return model.perform(Login(emailController.text, passwordController.text));
  }

  Future<bool> _signUp() {
    return model.perform(SignUp(emailController.text, passwordController.text));
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
}
