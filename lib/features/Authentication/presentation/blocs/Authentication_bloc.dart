import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/personal_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/practical_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/professional_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/profile_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/user.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/verification_model.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/check_user.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/create_account.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/login.dart';

part 'Authentication_event.dart';
part 'Authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Login login;
  final CheckUserUseCase checkUser;

  final CreateAccountUseCase createAccount;
  AuthenticationBloc(
      {required this.login,
      required this.createAccount,
      required this.checkUser})
      : super(AuthenticationInitial()) {
    on<LoginEvent>(onLoginHandler);
    on<CheckUser>(_checkUser);
    on<ProfessionalInfoEvent>(_professional);

    on<PracticalInfoEvent>(_PracticeInfo);

    on<VerificationInfoEvent>(_verification);

    on<ProfileInfoEvent>(_ProfileEvent);

    on<PersonalInfoEvent>(_personalInfo);
  }

  _ProfileEvent(ProfileInfoEvent event, Emitter emit) async {
    emit(ProfileInfoState(
        personalInfoModel: event.personalInfoModel,
        professionalInfoModel: event.professionalInfoModel,
        practicalInfoModel: event.practicalInfoModel,
        verificationInfoModel: event.verificationInfoModel,
        profileInfoModel: event.profileInfoEvent));
  }

  _verification(VerificationInfoEvent event, Emitter emit) async {
    emit(VerificationInfoState(
        personalInfoModel: event.personalInfoModel,
        professionalInfoModel: event.professionalInfoModel,
        practicalInfoModel: event.practicalInfoModel,
        verificationInfoModel: event.verificationInfoModel));
  }

  _PracticeInfo(PracticalInfoEvent event, Emitter emit) async {
    emit(PracticalInfoState(
        personalInfoModel: event.personalInfoModel,
        professionalInfoModel: event.professionalInfoModel,
        practicalInfoModel: event.practicalInfoModel));
  }

  _professional(ProfessionalInfoEvent event, Emitter emit) async {
    emit(ProfessionalInfoState(
        personalInfoModel: event.personalInfoModel,
        professionalInfoModel: event.professionalInfoModel));
  }

  _personalInfo(PersonalInfoEvent event, Emitter emit) async {
    emit(PersonalInfoState(personalInfoModel: event.personalInfoModel));
  }

  _checkUser(CheckUser event, Emitter emit) async {
    var result = await checkUser.call();

    result.fold((failure) {
      print(failure.message);
      emit(SetUserState());
    }, (userModel) {
      emit(UserAccount(userModel: userModel));
    });
  }

  onLoginHandler(LoginEvent event, Emitter emit) async {
    emit(LoginLoading());

    var result = await login
        .call(LoginParams(email: event.email, password: event.password));

    result.fold(
      (failure) {
        print(failure.message);
        emit(LoginFailed(message: failure.message));
      },
      (user) {
        emit(UserAccount(userModel: user));
      },
    );
  }
}
