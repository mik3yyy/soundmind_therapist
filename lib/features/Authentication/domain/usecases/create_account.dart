import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/personal_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/practical_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/professional_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/profile_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/verification_model.dart';
import 'package:soundmind_therapist/features/Authentication/domain/repositories/Authentication_repository.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';

class CreateAccountUseCase
    extends UsecaseWithParams<DataMap, CreateAccountParams> {
  final AuthenticationRepository _repository;

  CreateAccountUseCase({required AuthenticationRepository repository})
      : _repository = repository;
  @override
  ResultFuture<DataMap> call(CreateAccountParams params) =>
      _repository.createAccount(
        personalInfoModel: params.personalInfoModel,
        professionalInfoModel: params.professionalInfoModel,
        practicalInfoModel: params.practicalInfoModel,
        verificationInfoModel: params.verificationInfoModel,
        profileInfoEvent: params.profileInfoEvent,
      );
}

class CreateAccountParams {
  final PersonalInfoModel personalInfoModel;
  final ProfessionalInfoModel professionalInfoModel;
  final PracticalInfoModel practicalInfoModel;
  final VerificationInfoModel verificationInfoModel;
  final ProfileInfoModel profileInfoEvent;

  CreateAccountParams(
      {required this.personalInfoModel,
      required this.professionalInfoModel,
      required this.practicalInfoModel,
      required this.verificationInfoModel,
      required this.profileInfoEvent});
}
