part of 'Authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class LoginLoading extends AuthenticationState {}

class LoginFailed extends AuthenticationState {
  final String message;

  LoginFailed({required this.message});
}

class UserAccount extends AuthenticationState {
  final UserModel userModel;

  UserAccount({required this.userModel});
}

class SetUserState extends AuthenticationState {}

class PersonalInfoState extends AuthenticationState {
  final PersonalInfoModel personalInfoModel;

  const PersonalInfoState({required this.personalInfoModel});
}

class ProfessionalInfoState extends AuthenticationState {
  final PersonalInfoModel personalInfoModel;
  final ProfessionalInfoModel professionalInfoModel;

  const ProfessionalInfoState(
      {required this.personalInfoModel, required this.professionalInfoModel});
}

class PracticalInfoState extends AuthenticationState {
  final PersonalInfoModel personalInfoModel;
  final ProfessionalInfoModel professionalInfoModel;
  final PracticalInfoModel practicalInfoModel;

  const PracticalInfoState(
      {required this.personalInfoModel,
      required this.professionalInfoModel,
      required this.practicalInfoModel});
}

class VerificationInfoState extends AuthenticationState {
  final PersonalInfoModel personalInfoModel;
  final ProfessionalInfoModel professionalInfoModel;
  final PracticalInfoModel practicalInfoModel;
  final VerificationInfoModel verificationInfoModel;
  final String? message;
  const VerificationInfoState(
      {required this.personalInfoModel,
      this.message,
      required this.professionalInfoModel,
      required this.practicalInfoModel,
      required this.verificationInfoModel});
}

class ProfileInfoState extends AuthenticationState {
  final PersonalInfoModel personalInfoModel;
  final ProfessionalInfoModel professionalInfoModel;
  final PracticalInfoModel practicalInfoModel;
  final VerificationInfoModel verificationInfoModel;
  final ProfileInfoModel profileInfoModel;
  final String? message;
  const ProfileInfoState(
      {required this.personalInfoModel,
      required this.professionalInfoModel,
      required this.practicalInfoModel,
      required this.verificationInfoModel,
      this.message,
      required this.profileInfoModel});
}

class CreatingAccount extends AuthenticationState {}

class VerifyAccount extends AuthenticationState {
  final Map<String, dynamic> verificationData;

  final PersonalInfoModel personalInfoModel;
  final ProfessionalInfoModel professionalInfoModel;
  final PracticalInfoModel practicalInfoModel;
  final VerificationInfoModel verificationInfoModel;
  final ProfileInfoModel profileInfoModel;

  VerifyAccount(
      {required this.verificationData,
      required this.personalInfoModel,
      required this.professionalInfoModel,
      required this.practicalInfoModel,
      required this.verificationInfoModel,
      required this.profileInfoModel});
}

class VerifyingAccount extends AuthenticationState {}

class VeriftingAccountFailed extends AuthenticationState {
  final String message;
  final Map<String, dynamic> verificationData;

  VeriftingAccountFailed({
    required this.message,
    required this.verificationData,
  });
}
