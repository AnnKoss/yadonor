import 'package:flutter/material.dart';

import 'package:yadonor/ui/auth/widgets/auth_textformfield.dart';
import 'package:yadonor/model/auth/auth_validation.dart';

class LogInForm extends StatelessWidget {
  final Key loginKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocus, passwordFocus;

  LogInForm(
    this.loginKey,
    this.emailController,
    this.passwordController,
    this.emailFocus,
    this.passwordFocus,
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginKey,
      child: Column(
        children: <Widget>[
          authTextFormField(
            TextFormField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              focusNode: emailFocus,
              onFieldSubmitted: (term) {
                fieldFocusChange(context, emailFocus, passwordFocus);
              },
              decoration: InputDecoration(
                hintText: 'E-mail',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Icon(Icons.email),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: emailValidator,
            ),
          ),
          authTextFormField(
            TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              focusNode: passwordFocus,
              onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                hintText: 'Пароль',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(2),
                  child: Icon(Icons.lock),
                ),
              ),
              validator: passwordValidator,
              obscureText: true,
            ),
          ),
        ],
      ),
    );
  }
}
