import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/domain/repositories/Authentication_repository.dart';

class LogOutUsecase extends UsecaseWithoutParams<void> {
  final AuthenticationRepository _repository;

  LogOutUsecase({required AuthenticationRepository repository})
      : _repository = repository;
  @override
  ResultFuture<void> call() => _repository.logout();
}
