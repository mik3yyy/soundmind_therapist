part of 'Authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

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

  const VerificationInfoState(
      {required this.personalInfoModel,
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

  const ProfileInfoState(
      {required this.personalInfoModel,
      required this.professionalInfoModel,
      required this.practicalInfoModel,
      required this.verificationInfoModel,
      required this.profileInfoModel});
}
