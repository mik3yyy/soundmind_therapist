import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/network/network.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/data/datasources/Authentication_hive_data_source.dart';
import 'package:soundmind_therapist/features/Authentication/data/datasources/Authentication_remote_data_source.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/gas.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/personal_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/practical_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/professional_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/profile_data.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/profile_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/user.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/verification_model.dart';
import 'package:soundmind_therapist/features/Authentication/domain/repositories/Authentication_repository.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AuthenticationHiveDataSource _authenticationHiveDataSource;

  AuthenticationRepositoryImpl(
      {required AuthenticationRemoteDataSource authenticationRemoteDataSource,
      required AuthenticationHiveDataSource authenticationHiveDataSource})
      : _authenticationRemoteDataSource = authenticationRemoteDataSource,
        _authenticationHiveDataSource = authenticationHiveDataSource;

  @override
  ResultFuture<UserModel> login({required String email, required String password}) async {
    try {
      DataMap userData = await _authenticationRemoteDataSource.login(
        email: email,
        password: password,
      );
      print(userData);
      if (userData['isEmailVerified']) {
        UserModel userModel = UserModel.fromJson(userData);
        if (userModel.roles[0] == 'User') {
          return Left(ServerFailure("This is not a therapist account", data: userData));
        }
        _authenticationHiveDataSource.saveUser(userModel: userModel);
        return Right(userModel);
      } else {
        return Left(ServerFailure("User Not verified", data: userData));
      }
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<DataMap> createAccount({
    required PersonalInfoModel personalInfoModel,
  }) async {
    try {
      var verificationData = await _authenticationRemoteDataSource.createAccount(
        personalInfoModel: personalInfoModel,
      );
      return Right(verificationData);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<UserModel> checkUser() async {
    try {
      UserModel userModel = await _authenticationHiveDataSource.getUser();

      return Right(userModel);
    } catch (e) {
      print(e.toString());
      return const Left(CacheFailure("No User"));
    }
  }

  @override
  ResultFuture<void> changePassword(
      {required String old, required String newPassword, required String confirmPassword}) async {
    // TODO: implement changePassword
    try {
      await _authenticationRemoteDataSource.changePassword(
          old: old, newPassword: newPassword, confirmPassword: confirmPassword);

      return Right(null);
    } on ApiError catch (e) {
      print(e.toString());
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<void> logout() async {
    // TODO: implement logout
    try {
      await _authenticationHiveDataSource.deleteUser();

      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure("No User"));
    }
  }

  @override
  ResultFuture<UserModel> verifyEmail({required String otp, required String securityKey}) async {
    // TODO: implement verifyEmail
    try {
      UserModel userModel = await _authenticationRemoteDataSource.verifyEmail(otp: otp, securityKey: securityKey);
      // _authenticationHiveDataSource.saveUser(userModel: userModel);
      return Right(userModel);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    } catch (e) {
      return const Left(ServerFailure(ApiError.unknownError));
    }
  }

  @override
  ResultFuture<DataMap> checkIfPhoneAndEmailExist({
    required String email,
    required String phoneNumber,
  }) async {
    try {
      DataMap result = await _authenticationRemoteDataSource.checkIfPhoneAndEmailExist(
        email: email,
        phoneNumber: phoneNumber,
      );
      return Right(result);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<DataMap> resendVerificationOtp({
    required String signupKey,
  }) async {
    try {
      DataMap result = await _authenticationRemoteDataSource.resendVerificationOtp(
        signupKey: signupKey,
      );
      return Right(result);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<List<GASModel>> getGAS() async {
    try {
      DataMap result = await _authenticationRemoteDataSource.getGAS();
      List<GASModel> appointments = (result['data'] as List).map((json) => GASModel.fromJson(json)).toList();
      return Right(appointments);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<ProfileData> getProfileData() async {
    try {
      DataMap result = await _authenticationRemoteDataSource.getProfileData();
      ProfileData data = ProfileData.fromJson(result);
      return Right(data);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<void> uploadPracticalInfo({required PracticalInfoModel practicalInfoModel}) async {
    try {
      await _authenticationRemoteDataSource.uploadPracticalInfo(practicalInfoModel: practicalInfoModel);

      return Right(null);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<void> uploadProfessionalInfo({required ProfessionalInfoModel professionalInfoModel}) async {
    try {
      await _authenticationRemoteDataSource.uploadProfessionalInfo(professionalInfoModel: professionalInfoModel);

      return Right(null);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<void> uploadVerificarionInfo({required VerificationInfoModel verification_info}) async {
    try {
      UserModel userModel = await _authenticationHiveDataSource.getUser();

      await _authenticationRemoteDataSource.uploadVerificarionInfo(
          verificationInfoModel: verification_info, email: userModel.email);

      return Right(null);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }
}
