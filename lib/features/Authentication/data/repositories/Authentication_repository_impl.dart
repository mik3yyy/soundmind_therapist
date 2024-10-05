import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/network/network.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/data/datasources/Authentication_hive_data_source.dart';
import 'package:soundmind_therapist/features/Authentication/data/datasources/Authentication_remote_data_source.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/personal_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/practical_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/professional_info_model.dart';
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
    required ProfileInfoEvent profileInfoEvent,
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
}
