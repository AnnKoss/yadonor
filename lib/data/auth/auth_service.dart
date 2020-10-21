import 'package:firebase_auth/firebase_auth.dart';

import 'authentication.dart';

class AuthService {

  Future<User> login(String email, String password) async {
    User user;
    try {
      UserCredential authResult = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = authResult.user;
    } on FirebaseAuthException catch (error) {
      print('login failed: ' + error.code);
    }

    return user;
  }
}