import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/user.dart';
import 'package:soundmind_therapist/features/Authentication/domain/repositories/Authentication_repository.dart';

class CheckIfPhoneAndEmailExist
    extends UsecaseWithParams<DataMap, CheckIfPhoneAndEmailExistParams> {
  final AuthenticationRepository _repository;

  CheckIfPhoneAndEmailExist({required AuthenticationRepository repository})
      : _repository = repository;

  @override
  ResultFuture<DataMap> call(CheckIfPhoneAndEmailExistParams params) =>
      _repository.checkIfPhoneAndEmailExist(
        email: params.email,
        phoneNumber: params.phoneNumber,
      );
}

class CheckIfPhoneAndEmailExistParams {
  final String email;
  final String phoneNumber;

  CheckIfPhoneAndEmailExistParams({
    required this.email,
    required this.phoneNumber,
  });
}
