import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yadonor/ui/auth/widgets/signup/signup_form.dart';
import 'package:yadonor/ui/auth/auth_bloc.dart';
import 'package:yadonor/ui/auth/widgets/login/login_form.dart';
import 'package:yadonor/ui/button.dart';

// enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> signUpKey = GlobalKey();
  final GlobalKey<FormState> loginKey = GlobalKey();

// Map<String, String> _authData = {
//   'email': '',
//   'password': '',
// };

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  AuthBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = AuthBloc(AuthState(), context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          cubit: _bloc,
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
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
                                LogInForm(
                                  loginKey,
                                  emailController,
                                  passwordController,
                                  emailFocus,
                                  passwordFocus,
                                ),
                                SizedBox(height: 20),
                                button(
                                  context: context,
                                  buttonText: 'Войти',
                                  onPressed: () => _bloc.add(
                                    SubmitLoginEvent(
                                      emailController.text,
                                      passwordController.text,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                SizedBox(height: 30),
                                SignUpForm(
                                  signUpKey,
                                  emailController,
                                  passwordController,
                                  confirmPasswordController,
                                  emailFocus,
                                  passwordFocus,
                                  confirmPasswordFocus,
                                ),
                                SizedBox(height: 20),
                                button(
                                  context: context,
                                  buttonText: 'Зарегистрироваться',
                                  onPressed: () => _bloc.add(SubmitSignUpEvent(
                                    emailController.text,
                                    passwordController.text,
                                  )),
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
            );
          },
        ),
      ),
    );
  }
}
