part of 'Authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
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

class CreatingAccount extends AuthenticationState {}

class CreatingAccountFailed extends AuthenticationState {}

class SetUserState extends AuthenticationState {}

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
  final PersonalInfoModel? personalInfoModel;
  final ProfessionalInfoModel? professionalInfoModel;
  final PracticalInfoModel? practicalInfoModel;
  final VerificationInfoModel? verificationInfoModel;
  final ProfileInfoModel? profileInfoModel;
  final String? message;
  final int? page;

  const ProfileInfoState({
    this.personalInfoModel,
    this.professionalInfoModel,
    this.practicalInfoModel,
    this.verificationInfoModel,
    this.profileInfoModel,
    this.message,
    this.page,
  });

  @override
  List<Object?> get props => [
        personalInfoModel,
        professionalInfoModel,
        practicalInfoModel,
        verificationInfoModel,
        profileInfoModel,
        message,
        page,
      ];
}

class VerifyAccount extends AuthenticationState {
  final Map<String, dynamic> verificationData;
  final PersonalInfoModel? personalInfoModel;

  VerifyAccount({required this.verificationData, required this.personalInfoModel});
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
