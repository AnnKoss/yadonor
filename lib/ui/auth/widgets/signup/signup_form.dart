import 'package:flutter/material.dart';

import 'package:yadonor/ui/auth/auth_textformfield.dart';
import 'package:yadonor/data/auth/auth_validation.dart';

class SignUpForm extends StatelessWidget {
  final Key signUpKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final FocusNode emailFocus, passwordFocus;
  final FocusNode confirmPasswordFocus;

  SignUpForm(
    this.signUpKey,
    this.emailController,
    this.passwordController,
    this.confirmPasswordController,
    this.emailFocus,
    this.passwordFocus,
    this.confirmPasswordFocus,
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signUpKey,
      child: Column(
        children: <Widget>[
          authTextFormField(TextFormField(
            controller: emailController,
            textInputAction: TextInputAction.next,
            focusNode: emailFocus,
            onFieldSubmitted: (term) {
              fieldFocusChange(context, emailFocus, passwordFocus);
            },
            decoration: InputDecoration(
              hintText: 'E-mail',
              prefixIcon: Padding(
                padding: EdgeInsets.all(2),
                child: Icon(Icons.email),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: emailValidator,
            // onSaved: (value) {
            //   _authData['email'] = value;
            // print('email saved');
            // },
            // why not working?
          )),
          authTextFormField(TextFormField(
            controller: passwordController,
            textInputAction: TextInputAction.next,
            focusNode: passwordFocus,
            onFieldSubmitted: (term) {
              fieldFocusChange(context, passwordFocus, confirmPasswordFocus);
            },
            decoration: InputDecoration(
              hintText: 'Пароль',
              prefixIcon: Padding(
                padding: EdgeInsets.all(2),
                child: Icon(Icons.lock),
              ),
            ),
            validator: passwordValidator,
            obscureText: true,
          )),
          authTextFormField(TextFormField(
            controller: confirmPasswordController,
            textInputAction: TextInputAction.done,
            focusNode: confirmPasswordFocus,
            onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              hintText: 'Подтвердите пароль',
              prefixIcon: Padding(
                padding: EdgeInsets.all(2),
                child: Icon(Icons.lock),
              ),
            ),
            validator: (value) => confirmPasswordValidator(value, confirmPasswordController),
            obscureText: true,
          )),
        ],
      ),
    );
  }
}
