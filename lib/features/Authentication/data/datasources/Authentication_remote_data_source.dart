import 'package:dio/dio.dart';
import 'package:soundmind_therapist/core/network/network.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/personal_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/practical_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/professional_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/profile_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/user.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/verification_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<DataMap> createAccount({
    required PersonalInfoModel personalInfoModel,
    required ProfessionalInfoModel professionalInfoModel,
    required PracticalInfoModel practicalInfoModel,
    required VerificationInfoModel verificationInfoModel,
    required ProfileInfoModel profileInfoEvent,
  });
  Future<DataMap> login({required String email, required String password});
  Future<UserModel> verifyEmail(
      {required String otp, required String securityKey});

  Future<DataMap> updateUserDetails({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  });
  Future<DataMap> changePassword(
      {required String old,
      required String newPassword,
      required String confirmPassword});
  Future<DataMap> checkIfPhoneAndEmailExist({
    required String email,
    required String phoneNumber,
  });

  Future<DataMap> getGAS();

  Future<DataMap> resendVerificationOtp({required String signupKey});
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
      required ProfileInfoModel profileInfoEvent}) async {
    var degree = await verificationInfoModel.degree
        .toUploadJson(personalInfoModel.email, 'degree');

    var govID = await verificationInfoModel.govID
        .toUploadJson(personalInfoModel.email, "govID");
    var lincense = await verificationInfoModel.license
        .toUploadJson(personalInfoModel.email, 'lincense');
    var picture = await profileInfoEvent.profilePicture
        .toUploadJson(personalInfoModel.email, 'picture');

    if (degree == null ||
        govID == null ||
        lincense == null ||
        picture == null) {
      throw ApiError(errorDescription: "Unable to upload Images or documents");
    }
    Response response = await _network.call(
      "/Registration/RegisterPhysician",
      RequestMethod.post,
      data: {
        "email": personalInfoModel.email,
        "firstName": personalInfoModel.firstname,
        "lastName": personalInfoModel.lastname,
        "password": personalInfoModel.password,
        "phoneNumber": personalInfoModel.phoneNumber,
        "passwordConfirmation": personalInfoModel.passwordConfirmation,
        "dob": personalInfoModel.dob,
        "gender": personalInfoModel.gender,
        "qualifications": professionalInfoModel.qualifications
            .map((e) => e.toJson())
            .toList(),
        "uploads": [
          degree,
          govID,
          lincense,
          picture,
        ],
        "schedules": practicalInfoModel.schedules,
        "physician": {
          "yoe": professionalInfoModel.yoe,
          "professionalAffiliation":
              professionalInfoModel.professionalAffiliation,
          "specialtyId":
              int.parse(professionalInfoModel.aos), //personalInfoModel.,
          "bio": profileInfoEvent.bio,
          "licenseNum": professionalInfoModel.licenseNum,
          "issuingAuthority": professionalInfoModel.issuingAuthority,
          "licenseExpiryDate": professionalInfoModel.licenseExpiryDate,
          "placeOfWork": practicalInfoModel.practiceAddress,
          "clinicAddress": practicalInfoModel.practiceAddress,
          "consultationRate": practicalInfoModel.consultationRate
        }
      },
    );
    print(response.data);
    return response.data;
  }

  @override
  Future<DataMap> changePassword(
      {required String old,
      required String newPassword,
      required String confirmPassword}) async {
    Response response = await _network.call(
      "/Settings/ChangePassword",
      RequestMethod.patch,
      data: {
        "oldPassword": old,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword
      },
    );
    return response.data;
  }

  @override
  Future<DataMap> updateUserDetails(
      {required String firstName,
      required String lastName,
      required String phoneNumber}) async {
    Response response = await _network.call(
      "/Settings/UpdateUserDetails",
      RequestMethod.patch,
      data: {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber
      },
    );
    return response.data;
  }

  @override
  Future<UserModel> verifyEmail(
      {required String otp, required String securityKey}) async {
    Response response = await _network.call(
      "/Registration/VerifyAccount",
      RequestMethod.patch,
      data: {
        "otp": otp,
        "signupKey": securityKey,
      },
    );
    print(response.data);
    return UserModel.fromJson(response.data['data']);
  }

  @override
  Future<DataMap> checkIfPhoneAndEmailExist({
    required String email,
    required String phoneNumber,
  }) async {
    Response response = await _network.call(
      "/Utilities/CheckIfPhoneAndEmailExist",
      RequestMethod.post,
      data: {
        "email": email,
        "phoneNumber": phoneNumber,
      },
    );
    return response.data;
  }

  @override
  Future<DataMap> resendVerificationOtp({required String signupKey}) async {
    Response response = await _network.call(
      "/Registration/ResendVerificationOtp",
      RequestMethod.post,
      data: {
        "signupKey": signupKey,
      },
    );
    return response.data;
  }

  @override
  Future<DataMap> getGAS() async {
    Response response = await _network.call(
      "/Registration/GetAreasOfSpecialization",
      RequestMethod.get,
    );
    return response.data;
  }
}
