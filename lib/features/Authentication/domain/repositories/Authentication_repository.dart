import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/personal_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/practical_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/professional_info_model.dart';
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
    required ProfessionalInfoModel professionalInfoModel,
    required PracticalInfoModel practicalInfoModel,
    required VerificationInfoModel verificationInfoModel,
    required ProfileInfoModel profileInfoEvent,
  });
  ResultFuture<UserModel> checkUser();
  ResultFuture<void> logout();
  ResultFuture<void> changePassword(
      {required String old,
      required String newPassword,
      required String confirmPassword});
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
}
