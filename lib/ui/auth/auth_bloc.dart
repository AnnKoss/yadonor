import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yadonor/data/auth/auth_service.dart';

import '../../data/auth/authentication.dart';
import '../main_screen.dart';
import 'authentication_error_dialog.dart';

abstract class AuthEvent {

}

/// Submit field event
class SubmitLoginEvent extends AuthEvent{
  final String email;
  final String password;

  SubmitLoginEvent(this.email, this.password);
}

class AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {}


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _service = AuthService();

  final BuildContext context;
  AuthBloc(AuthState initialState, this.context ) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) {
    if (event is SubmitLoginEvent) {
      return _performLogin(event);
    } else {
      throw UnimplementedError();
    }
  }

  Stream<AuthState> _performLogin(SubmitLoginEvent event)  async* {
    yield AuthLoadingState();

    User user = await _service.login(event.email, event.password);

    if (user != null) {
      Navigator.of(context).pushReplacementNamed(MainScreen.routeName);

      // sign in successfully
    } else {
      yield AuthErrorState();
      authenticationErrorDialog(context);
    }
  }
}


