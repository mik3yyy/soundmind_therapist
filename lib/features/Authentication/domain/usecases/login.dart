import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/user.dart';
import 'package:soundmind_therapist/features/Authentication/domain/repositories/Authentication_repository.dart';

class Login extends UsecaseWithParams<UserModel, LoginParams> {
  final AuthenticationRepository _repository;

  Login({required AuthenticationRepository repository})
      : _repository = repository;
  @override
  ResultFuture<UserModel> call(LoginParams params) =>
      _repository.login(email: params.email, password: params.password);
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
