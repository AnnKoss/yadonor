import 'package:surf_mwwm/surf_mwwm.dart';

import 'package:yadonor/model/auth/changes.dart';
import 'package:yadonor/model/auth/repository/auth_repository.dart';

class LoginPerformer extends FuturePerformer<bool, Login> {
  final AuthRepository _service;
  LoginPerformer(this._service);

  @override
  Future<bool> perform(Login change) =>
      _service.login(change.email, change.password);
}

class SignUpPerformer extends FuturePerformer<bool, Login> {
  final AuthRepository _service;
  SignUpPerformer(this._service);

  @override
  Future<bool> perform(Login change) =>
      _service.signUp(change.email, change.password);
}
