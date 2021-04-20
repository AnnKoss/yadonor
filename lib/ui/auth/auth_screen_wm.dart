import 'package:flutter/material.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:yadonor/model/auth/repository/auth_repository.dart';

import 'package:yadonor/ui/main_screen/main_screen.dart';
import 'package:yadonor/model/auth/changes.dart';
import 'package:yadonor/model/auth/performers.dart';

/// WidgetModel for auth_screen
class AuthWidgetModel extends WidgetModel {
  static WidgetModel buildAuthScreenWM(BuildContext context) {
    return AuthWidgetModel(
      WidgetModelDependencies(),
      Model(
        [
          LoginPerformer(
            AuthRepository(),
          ),
          SignUpPerformer(
            AuthRepository(),
          ),
        ],
      ),
      Navigator.of(context),
    );
  }

  final NavigatorState navigator;
  final isLoading = StreamedState<bool>(false);

  AuthWidgetModel(
    WidgetModelDependencies dependencies,
    Model model,
    this.navigator,
  ) : super(
          dependencies,
          model: model,
        );

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
