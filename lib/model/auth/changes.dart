import 'package:surf_mwwm/surf_mwwm.dart';
// import 'package:yadonor/domain/appointment-item.dart';

class Login extends FutureChange<bool> {
  String email;
  String password;
  Login(this.email, this.password); 
}


class SignUp extends FutureChange<bool> {
  String email;
  String password;
  SignUp(this.email, this.password); 
}