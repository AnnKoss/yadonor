import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> login(String email, String password) async {
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

    return user;
  }

  Future<User> signUp(String email, String password) async {
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

    return user;
  }
}
