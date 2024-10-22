import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/domain/repositories/Authentication_repository.dart';

class ChangePasswordUseCase
    extends UsecaseWithParams<void, ChangePasswordUseCaseParams> {
  final AuthenticationRepository _repository;

  ChangePasswordUseCase({required AuthenticationRepository repository})
      : _repository = repository;
  @override
  ResultFuture<void> call(ChangePasswordUseCaseParams params) =>
      _repository.changePassword(
          old: params.old,
          newPassword: params.newPassword,
          confirmPassword: params.confirmPassword);
}

class ChangePasswordUseCaseParams {
  final String old;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordUseCaseParams(
      {required this.old,
      required this.newPassword,
      required this.confirmPassword});
}
