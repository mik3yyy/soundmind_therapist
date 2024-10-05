import 'package:dio/dio.dart';
import 'package:soundmind_therapist/core/network/network.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/personal_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/practical_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/professional_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/verification_model.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';

abstract class AuthenticationRemoteDataSource {
  Future<DataMap> createAccount({
    required PersonalInfoModel personalInfoModel,
    required ProfessionalInfoModel professionalInfoModel,
    required PracticalInfoModel practicalInfoModel,
    required VerificationInfoModel verificationInfoModel,
    required ProfileInfoEvent profileInfoEvent,
  });
  Future<DataMap> login({required String email, required String password});
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  final Network _network;

  AuthenticationRemoteDataSourceImpl({required Network network})
      : _network = network;

  @override
  Future<DataMap> login(
      {required String email, required String password}) async {
    Response response = await _network.call(
      "/Auth/Login",
      RequestMethod.post,
      data: {
        "email": email,
        "password": password,
      },
    );
    return response.data['data'];
  }

  @override
  Future<DataMap> createAccount(
      {required PersonalInfoModel personalInfoModel,
      required ProfessionalInfoModel professionalInfoModel,
      required PracticalInfoModel practicalInfoModel,
      required VerificationInfoModel verificationInfoModel,
      required ProfileInfoEvent profileInfoEvent}) {
    throw UnimplementedError();
  }
}
