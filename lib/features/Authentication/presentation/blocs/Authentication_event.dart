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

  const PersonalInfoEvent({required this.personalInfoModel});
}

class ProfessionalInfoEvent extends AuthenticationEvent {
  final PersonalInfoModel personalInfoModel;
  final ProfessionalInfoModel professionalInfoModel;

  const ProfessionalInfoEvent(
      {required this.personalInfoModel, required this.professionalInfoModel});
}

class PracticalInfoEvent extends AuthenticationEvent {
  final PersonalInfoModel personalInfoModel;
  final ProfessionalInfoModel professionalInfoModel;
  final PracticalInfoModel practicalInfoModel;

  const PracticalInfoEvent(
      {required this.personalInfoModel,
      required this.professionalInfoModel,
      required this.practicalInfoModel});
}

class VerificationInfoEvent extends AuthenticationEvent {
  final PersonalInfoModel personalInfoModel;
  final ProfessionalInfoModel professionalInfoModel;
  final PracticalInfoModel practicalInfoModel;
  final VerificationInfoModel verificationInfoModel;

  const VerificationInfoEvent(
      {required this.personalInfoModel,
      required this.professionalInfoModel,
      required this.practicalInfoModel,
      required this.verificationInfoModel});
}

class ProfileInfoEvent extends AuthenticationEvent {
  final PersonalInfoModel personalInfoModel;
  final ProfessionalInfoModel professionalInfoModel;
  final PracticalInfoModel practicalInfoModel;
  final VerificationInfoModel verificationInfoModel;
  final ProfileInfoEvent profileInfoEvent;

  const ProfileInfoEvent(
      {required this.personalInfoModel,
      required this.professionalInfoModel,
      required this.practicalInfoModel,
      required this.verificationInfoModel,
      required this.profileInfoEvent});
}
