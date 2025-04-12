import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/personal_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/practical_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/professional_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/profile_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/verification_model.dart';
import 'package:soundmind_therapist/features/Authentication/domain/repositories/Authentication_repository.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';

class CreateAccountUseCase extends UsecaseWithParams<DataMap, CreateAccountParams> {
  final AuthenticationRepository _repository;

  CreateAccountUseCase({required AuthenticationRepository repository}) : _repository = repository;
  @override
  ResultFuture<DataMap> call(CreateAccountParams params) => _repository.createAccount(
        personalInfoModel: params.personalInfoModel,
      );
}

class CreateAccountParams {
  final PersonalInfoModel personalInfoModel;

  CreateAccountParams({
    required this.personalInfoModel,
  });
}
