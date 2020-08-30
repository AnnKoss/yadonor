import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Auth with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  User get getUser {
    User user = _auth.currentUser;
    return user;
  }
}