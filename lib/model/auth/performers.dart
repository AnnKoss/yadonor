import 'package:surf_mwwm/surf_mwwm.dart';

// import 'package:yadonor/domain/appointment-item.dart';
import 'package:yadonor/model/auth/changes.dart';
import 'package:yadonor/model/auth/repository/auth_repository.dart';

class LoginPerformer
    extends FuturePerformer<bool, Login> {
  final AuthRepository _service;
  final String email;
  final String password;
  
  LoginPerformer(this._service, this.email, this.password);

  @override
  Future<bool> perform(Login change) =>
      _service.login(email, password);
}

class SignUpPerformer
    extends FuturePerformer<bool, Login> {
  final AuthRepository _service;
  final String email;
  final String password;
  
  SignUpPerformer(this._service, this.email, this.password);

  @override
  Future<bool> perform(Login change) =>
      _service.signUp(email, password);
}