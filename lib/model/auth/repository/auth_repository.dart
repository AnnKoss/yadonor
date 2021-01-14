import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> login(String email, String password) async {
    User user;
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = authResult.user;
    } on FirebaseAuthException catch (error) {
      print('login failed: ' + error.code);
    }
    if (user != null) {
      return true;
    } else
      return false;
  }

  Future<bool> signUp(String email, String password) async {
    User user;
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = authResult.user;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        print(
            'Аккаунт с таким e-mail уже существует'); //ToDo: show user error message
      }
      print('signup failed: ' + error.code);
    }

     if (user != null) {
      return true;
    } else
      return false;

  }
}
