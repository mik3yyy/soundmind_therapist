part of 'Authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class CheckUser extends AuthenticationEvent {}

class PersonalInfoEvent extends AuthenticationEvent {
  final PersonalInfoModel personalInfoModel;
  final int? page;

  const PersonalInfoEvent({this.page, required this.personalInfoModel});
}

class ProfessionalInfoEvent extends AuthenticationEvent {
  final ProfessionalInfoModel professionalInfoModel;
  final int? page;

  const ProfessionalInfoEvent({this.page, required this.professionalInfoModel});
}

class PracticalInfoEvent extends AuthenticationEvent {
  final PracticalInfoModel practicalInfoModel;
  final int? page;

  const PracticalInfoEvent({this.page, required this.practicalInfoModel});
}

class VerificationInfoEvent extends AuthenticationEvent {
  final int? page;

  final VerificationInfoModel verificationInfoModel;

  const VerificationInfoEvent({this.page, required this.verificationInfoModel});
}

class ProfileInfoEvent extends AuthenticationEvent {
  final int? page;

  final ProfileInfoModel profileInfoEvent;

  const ProfileInfoEvent({this.page, required this.profileInfoEvent});
}

class VerifyEmailEvent extends AuthenticationEvent {
  final DataMap verificationData;
  final String otp;

  const VerifyEmailEvent({required this.verificationData, required this.otp});
}

class ResendOtpEvent extends AuthenticationEvent {
  final String signupKey;

  ResendOtpEvent({required this.signupKey});
}
