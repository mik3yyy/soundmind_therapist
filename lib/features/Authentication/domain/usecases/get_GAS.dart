import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/gas.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/user.dart';
import 'package:soundmind_therapist/features/Authentication/domain/repositories/Authentication_repository.dart';

class GetGasUsecase extends UsecaseWithoutParams<List<GASModel>> {
  final AuthenticationRepository _repository;

  GetGasUsecase({required AuthenticationRepository repository})
      : _repository = repository;
  @override
  ResultFuture<List<GASModel>> call() => _repository.getGAS();
}
