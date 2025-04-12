import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/practical_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/professional_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/profile_data.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/verification_model.dart';
import 'package:soundmind_therapist/features/Authentication/domain/repositories/Authentication_repository.dart';

part 'therapist_profile_state.dart';

class TherapistProfileCubit extends Cubit<TherapistProfileState> {
  final AuthenticationRepository repository;

  TherapistProfileCubit({required this.repository}) : super(TherapistProfileInitial());

  ProfileData? profileData;
  int? falseFields;

  Future<void> getData() async {
    emit(GetInitialDataLoading());

    var result = await repository.getProfileData();

    result.fold((failure) {
      emit(GetInitialDataFailure());
    }, (data) {
      profileData = data;
      falseFields = countFalseFields(profileData);

      emit(GetInitialDataLoaded());
    });
  }

  Future<void> uploadProfessionalInfo(ProfessionalInfoModel professionalInfoModel) async {
    emit(TherapistProfileLoading());
    var result = await repository.uploadProfessionalInfo(professionalInfoModel: professionalInfoModel);

    result.fold((failure) {
      emit(TherapistProfileFailue(message: failure.message));
    }, (data) {
      profileData!.professionalInformationCompleted = true;

      falseFields = countFalseFields(profileData);

      emit(TherapistProfileSuccess());
    });
  }

  Future<void> uploadPracticeInfo(PracticalInfoModel practicalInfoModel) async {
    emit(TherapistProfileLoading());
    var result = await repository.uploadPracticalInfo(practicalInfoModel: practicalInfoModel);

    result.fold((failure) {
      emit(TherapistProfileFailue(message: failure.message));
    }, (data) {
      profileData!.practiceInformationCompleted = true;

      falseFields = countFalseFields(profileData);

      emit(TherapistProfileSuccess());
    });
  }

  Future<void> uploadVerificarionInfo(VerificationInfoModel verificationInfoModel) async {
    emit(TherapistProfileLoading());
    var result = await repository.uploadVerificarionInfo(verification_info: verificationInfoModel);

    result.fold((failure) {
      emit(TherapistProfileFailue(message: failure.message));
    }, (data) {
      profileData!.verificationDocumentCompleted = true;

      falseFields = countFalseFields(profileData);

      emit(TherapistProfileSuccess());
    });
  }

  int countFalseFields(ProfileData? profileData) {
    if (profileData == null) {
      return 0; // Return 0 if profileData is null
    }

    int falseCount = 0;

    // Convert the ProfileData to a map
    Map<String, dynamic> dataMap = profileData.toJson();

    // Iterate through each field in the map
    dataMap.forEach((key, value) {
      // Check if the value is boolean and false
      if (value is bool && value == false) {
        falseCount++;
      }
    });

    return falseCount;
  }
}
