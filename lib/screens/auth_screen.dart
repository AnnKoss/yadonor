import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../providers/calendar_events_provider.dart';
import '../screens/main_screen.dart';
import '../widgets/button.dart';

// enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _signUpKey = GlobalKey();
  final GlobalKey<FormState> _loginKey = GlobalKey();
  // Map<String, String> _authData = {
  //   'email': '',
  //   'password': '',
  // };

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _submitSignUp() async {
    _signUpKey.currentState.save();
    print(_signUpKey.toString());
    // _authData['email'] = _emailController.text;
    // _authData['password'] = _passwordController.text;
    // _authData['email'] = 'test@gmail.com';
    // _authData['password'] = 'password';

    print(_emailController.text);
    print(_passwordController.text);

    if (!_signUpKey.currentState.validate()) {
      // invalid!
      return;
    }
    print('validation succeded');

    User user;
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      user = authResult.user;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        print('Аккаунт с таким e-mail уже существует'); //ToDo: show user error message
      }
      print('signup failed: ' + error.code);
    } finally { //ToDo: remove finally
      if (user != null) {
        Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
        
        // sign in successfully
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            content: Text('Ошибка. Попробуйте ещё раз.'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('Закрыть'),
              )
            ],
          ),
        );
      }
    }
    //  ...do to submit
  }

  Future<void> _submitLogin() async {
    // _authData['email'] = _emailController.text;
    // _authData['password'] = _passwordController.text;

    print(_emailController.text);
    print(_passwordController.text);

    if (!_loginKey.currentState.validate()) {
      // invalid!
      return;
    }
    _loginKey.currentState.save();
    print('validation succeded');

    UserCredential authResult;
    try {
      authResult = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } catch (error) {
      print(error.code);
    } finally {
      if (authResult != null) {
        Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
        // Provider.of<CalendarEventsProvider>(context, listen: false).fetchEvents().then((_) => print('events fetched'));
        print('fetchEvents');
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            content: Text('Ошибка. Попробуйте ещё раз.'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('Закрыть'),
              )
            ],
          ),
        );
      }
    }
    //  ...do to submit
  }

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
                            Form(
                              key: _loginKey,
                              child: Column(
                                children: <Widget>[
                                  _buildTextFormField(TextFormField(
                                    controller: _emailController,
                                    textInputAction: TextInputAction.next,
                                    focusNode: _emailFocus,
                                    onFieldSubmitted: (term) {
                                      _fieldFocusChange(
                                          context, _emailFocus, _passwordFocus);
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
                                  )),
                                  _buildTextFormField(TextFormField(
                                    controller: _passwordController,
                                    textInputAction: TextInputAction.done,
                                    focusNode: _passwordFocus,
                                    onFieldSubmitted: (_) =>
                                        FocusScope.of(context).unfocus(),
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
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            button(
                              context: context,
                              buttonText: 'Войти',
                              onPressed: _submitLogin,
                            ),
                          ],
                        ),
                        Form(
                          key: _signUpKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 30),
                              Form(
                                child: Column(
                                  children: <Widget>[
                                    _buildTextFormField(TextFormField(
                                      controller: _emailController,
                                      textInputAction: TextInputAction.next,
                                      focusNode: _emailFocus,
                                      onFieldSubmitted: (term) {
                                        _fieldFocusChange(context, _emailFocus,
                                            _passwordFocus);
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
                                        return (!RegExp(pattern)
                                                .hasMatch(value))
                                            ? 'Invalid email'
                                            : null;
                                      },
                                      // onSaved: (value) {
                                      //   _authData['email'] = value;
                                      // print('email saved');
                                      // },
                                      // why not working?
                                    )),
                                    _buildTextFormField(TextFormField(
                                      controller: _passwordController,
                                      textInputAction: TextInputAction.next,
                                      focusNode: _passwordFocus,
                                      onFieldSubmitted: (term) {
                                        _fieldFocusChange(
                                            context,
                                            _passwordFocus,
                                            _confirmPasswordFocus);
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Пароль',
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Icon(Icons.lock),
                                        ),
                                      ),
                                      validator: (value) {
                                        return (value.isEmpty ||
                                                value.length < 6)
                                            ? 'Invalid Password'
                                            : null;
                                      },
                                      obscureText: true,
                                    )),
                                    _buildTextFormField(TextFormField(
                                      controller: _confirmPasswordController,
                                      textInputAction: TextInputAction.done,
                                      focusNode: _confirmPasswordFocus,
                                      onFieldSubmitted: (_) =>
                                          FocusScope.of(context).unfocus(),
                                      decoration: InputDecoration(
                                        hintText: 'Подтвердите пароль',
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Icon(Icons.lock),
                                        ),
                                      ),
                                      validator: (value) {
                                        return (value !=
                                                _passwordController.text)
                                            ? 'Пароль введен неверно'
                                            : null;
                                      },
                                      obscureText: true,
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              button(
                                context: context,
                                buttonText: 'Зарегистрироваться',
                                onPressed: _submitSignUp,
                              ),
                            ],
                          ),
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

// class SignIn extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         SizedBox(height: 30),
//         _buildEmailTextFormField('E-mail', Icons.email),
//         _buildEmailTextFormField('Пароль', Icons.lock),
//         SizedBox(height: 20),
//         button(context: context, buttonText: 'Войти', onPressed: () {}),
//       ],
//     );
//   }
// }

// class SignUp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         SizedBox(height: 30),
//         _buildEmailTextFormField('E-mail', Icons.email),
//         _buildEmailTextFormField('Пароль', Icons.lock),
//         _buildEmailTextFormField('Подтвердите пароль', Icons.lock),
//         SizedBox(height: 20),
//         button(
//             context: context,
//             buttonText: 'Зарегистрироваться',
//             onPressed: () {}),
//       ],
//     );
//   }
// }

Widget _buildTextFormField(TextFormField textFormField) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    // height: 60,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    child: textFormField,
  );
}

//ToDo: create theme file with build-blabla