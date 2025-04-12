import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/gas.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/personal_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/practical_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/professional_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/profile_data.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/profile_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/user.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/verification_model.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';

abstract class AuthenticationRepository {
  // Define abstract methods here
  ResultFuture<UserModel> login({
    required String email,
    required String password,
  });

  ResultFuture<DataMap> createAccount({
    required PersonalInfoModel personalInfoModel,
  });
  ResultFuture<UserModel> checkUser();
  ResultFuture<void> logout();

  ResultFuture<ProfileData> getProfileData();
  ResultFuture<void> changePassword(
      {required String old, required String newPassword, required String confirmPassword});
  ResultFuture<UserModel> verifyEmail({
    required String otp,
    required String securityKey,
  });
  ResultFuture<DataMap> checkIfPhoneAndEmailExist({
    required String email,
    required String phoneNumber,
  });

  ResultFuture<DataMap> resendVerificationOtp({
    required String signupKey,
  });
  ResultFuture<List<GASModel>> getGAS();
  ResultFuture<void> uploadProfessionalInfo({required ProfessionalInfoModel professionalInfoModel});
  ResultFuture<void> uploadPracticalInfo({required PracticalInfoModel practicalInfoModel});
  ResultFuture<void> uploadVerificarionInfo({required VerificationInfoModel verification_info});
}
