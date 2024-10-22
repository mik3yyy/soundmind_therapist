import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/network/network.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/data/datasources/Authentication_hive_data_source.dart';
import 'package:soundmind_therapist/features/Authentication/data/datasources/Authentication_remote_data_source.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/personal_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/practical_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/professional_info_model.dart';
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
  ResultFuture<UserModel> login(
      {required String email, required String password}) async {
    try {
      DataMap userData = await _authenticationRemoteDataSource.login(
        email: email,
        password: password,
      );
      print(userData);
      if (userData['isEmailVerified']) {
        UserModel userModel = UserModel.fromJson(userData);

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
    required ProfessionalInfoModel professionalInfoModel,
    required PracticalInfoModel practicalInfoModel,
    required VerificationInfoModel verificationInfoModel,
    required ProfileInfoModel profileInfoEvent,
  }) async {
    try {
      var verificationData =
          await _authenticationRemoteDataSource.createAccount(
              personalInfoModel: personalInfoModel,
              professionalInfoModel: professionalInfoModel,
              practicalInfoModel: practicalInfoModel,
              verificationInfoModel: verificationInfoModel,
              profileInfoEvent: profileInfoEvent);
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
      {required String old,
      required String newPassword,
      required String confirmPassword}) async {
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
  ResultFuture<UserModel> verifyEmail(
      {required String otp, required String securityKey}) async {
    // TODO: implement verifyEmail
    try {
      UserModel userModel = await _authenticationRemoteDataSource.verifyEmail(
          otp: otp, securityKey: securityKey);
      _authenticationHiveDataSource.saveUser(userModel: userModel);
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
      DataMap result =
          await _authenticationRemoteDataSource.checkIfPhoneAndEmailExist(
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
      DataMap result =
          await _authenticationRemoteDataSource.resendVerificationOtp(
        signupKey: signupKey,
      );
      return Right(result);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }
}
