import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/user.dart';
import 'package:soundmind_therapist/features/Authentication/domain/repositories/Authentication_repository.dart';

class CheckUserUseCase extends UsecaseWithoutParams<UserModel> {
  final AuthenticationRepository _repository;

  CheckUserUseCase({required AuthenticationRepository repository})
      : _repository = repository;
  @override
  ResultFuture<UserModel> call() => _repository.checkUser();
}
