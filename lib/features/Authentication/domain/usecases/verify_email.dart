import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/user.dart';
import 'package:soundmind_therapist/features/Authentication/domain/repositories/Authentication_repository.dart';

class VerifyEmail extends UsecaseWithParams<UserModel, VerifyEmailParams> {
  final AuthenticationRepository _repository;

  VerifyEmail({required AuthenticationRepository repository})
      : _repository = repository;
  @override
  ResultFuture<UserModel> call(VerifyEmailParams params) =>
      _repository.verifyEmail(otp: params.otp, securityKey: params.securityKey);
}

class VerifyEmailParams {
  final String otp;
  final String securityKey;

  VerifyEmailParams({required this.otp, required this.securityKey});
}
