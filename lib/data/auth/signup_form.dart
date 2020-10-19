import 'package:flutter/material.dart';

import 'package:yadonor/data/auth/authentication.dart';
import 'package:yadonor/ui/auth/auth_textformfield.dart';

class SignUpForm extends StatelessWidget {
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
            validator: (value) {
              Pattern pattern =
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
              return (!RegExp(pattern).hasMatch(value))
                  ? 'Invalid email'
                  : null;
            },
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
            validator: (value) {
              return (value.isEmpty || value.length < 6)
                  ? 'Invalid Password'
                  : null;
            },
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
            validator: (value) {
              return (value != passwordController.text)
                  ? 'Пароль введен неверно'
                  : null;
            },
            obscureText: true,
          )),
        ],
      ),
    );
  }
}
