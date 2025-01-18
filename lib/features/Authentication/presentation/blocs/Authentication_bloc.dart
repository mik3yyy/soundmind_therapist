import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/personal_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/practical_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/professional_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/profile_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/user.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/verification_model.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/check_user.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/create_account.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/log_out.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/login.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/resend_otp.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/verify_email.dart';

part 'Authentication_event.dart';
part 'Authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Login login;
  final CheckUserUseCase checkUser;

  final CreateAccountUseCase createAccount;

  final VerifyEmail verifyEmail;
  final LogOutUsecase logOutUsecase;
  final ResendVerificationOtp resendVerificationOtp;

  AuthenticationBloc(
      {required this.login,
      required this.createAccount,
      required this.verifyEmail,
      required this.resendVerificationOtp,
      required this.logOutUsecase,
      required this.checkUser})
      : super(AuthenticationInitial()) {
    on<LoginEvent>(onLoginHandler);
    on<CheckUser>(_checkUser);
    on<ProfessionalInfoEvent>(_professional);
    on<PracticalInfoEvent>(_PracticeInfo);
    on<VerificationInfoEvent>(_verification);
    on<ProfileInfoEvent>(_ProfileEvent);
    on<PersonalInfoEvent>(_personalInfo);
    on<VerifyEmailEvent>(_verifyEmail);
    on<ResendOtpEvent>(_resendOtp); // Add this line
  }
  _resendOtp(ResendOtpEvent event, Emitter emit) async {}

  _verifyEmail(VerifyEmailEvent event, Emitter emit) async {
    emit(VerifyingAccount());
    var result = await verifyEmail.call(
      VerifyEmailParams(
          otp: event.otp, securityKey: event.verificationData['data']),
    );

    result.fold((failure) {
      emit(VeriftingAccountFailed(
          message: failure.message, verificationData: event.verificationData));
    }, (UserModel) {
      emit(UserAccount(userModel: UserModel));
    });
  }

  _ProfileEvent(ProfileInfoEvent event, Emitter emit) async {
    if (state is ProfileInfoState) {
      var current = state as ProfileInfoState;

      emit(CreatingAccount());

      if (current.personalInfoModel == null) {
        emit(ProfileInfoState(
          page: 4,
          message: "Missing field on Personal Info Page",
          personalInfoModel: current.personalInfoModel!,
          professionalInfoModel: current.professionalInfoModel!,
          practicalInfoModel: current.practicalInfoModel!,
          verificationInfoModel: current.verificationInfoModel!,
        ));
        return;
      }
      if (current.professionalInfoModel == null) {
        emit(ProfileInfoState(
          page: 4,
          message: "Missing field on Professional Info Page",
          personalInfoModel: current.personalInfoModel!,
          professionalInfoModel: current.professionalInfoModel!,
          practicalInfoModel: current.practicalInfoModel!,
          verificationInfoModel: current.verificationInfoModel!,
        ));
        return;
      }
      if (current.practicalInfoModel == null) {
        emit(ProfileInfoState(
          page: 4,
          message: "Missing field on Pratcial Info Page",
          personalInfoModel: current.personalInfoModel!,
          professionalInfoModel: current.professionalInfoModel!,
          practicalInfoModel: current.practicalInfoModel!,
          verificationInfoModel: current.verificationInfoModel!,
        ));
        return;
      }
      if (current.verificationInfoModel == null) {
        emit(ProfileInfoState(
          page: 4,
          message: "Missing field on Profile Info Page",
          personalInfoModel: current.personalInfoModel!,
          professionalInfoModel: current.professionalInfoModel!,
          practicalInfoModel: current.practicalInfoModel!,
          verificationInfoModel: current.verificationInfoModel!,
        ));
        return;
      }

      var result = await createAccount.call(
        CreateAccountParams(
            personalInfoModel: current.personalInfoModel!,
            professionalInfoModel: current.professionalInfoModel!,
            practicalInfoModel: current.practicalInfoModel!,
            verificationInfoModel: current.verificationInfoModel!,
            profileInfoEvent: event.profileInfoEvent),
      );

      result.fold((failure) {
        emit(ProfileInfoState(
          page: 4,
          message: failure.message,
          personalInfoModel: current.personalInfoModel!,
          professionalInfoModel: current.professionalInfoModel!,
          practicalInfoModel: current.practicalInfoModel!,
          verificationInfoModel: current.verificationInfoModel!,
        ));
      }, (verify) {
        emit(VerifyAccount(
          personalInfoModel: current.personalInfoModel!,
          professionalInfoModel: current.professionalInfoModel!,
          practicalInfoModel: current.practicalInfoModel!,
          verificationInfoModel: current.verificationInfoModel!,
          profileInfoModel: event.profileInfoEvent,
          verificationData: verify,
        ));
      });
    }
  }

  _verification(VerificationInfoEvent event, Emitter emit) async {
    if (state is ProfileInfoState) {
      var current = state as ProfileInfoState;

      emit(ProfileInfoState(
          personalInfoModel: current.personalInfoModel,
          practicalInfoModel: current.practicalInfoModel,
          professionalInfoModel: current.professionalInfoModel,
          profileInfoModel: current.profileInfoModel,
          page: event.page,
          verificationInfoModel: event.verificationInfoModel));
    } else {
      emit(ProfileInfoState(
          page: event.page,
          verificationInfoModel: event.verificationInfoModel));
    }
  }

  _PracticeInfo(PracticalInfoEvent event, Emitter emit) async {
    if (state is ProfileInfoState) {
      var current = state as ProfileInfoState;

      emit(ProfileInfoState(
          personalInfoModel: current.personalInfoModel,
          practicalInfoModel: event.practicalInfoModel,
          professionalInfoModel: current.professionalInfoModel,
          profileInfoModel: current.profileInfoModel,
          page: event.page,
          verificationInfoModel: current.verificationInfoModel));
    } else {
      emit(ProfileInfoState(
          page: event.page, practicalInfoModel: event.practicalInfoModel));
    }
  }

  _professional(ProfessionalInfoEvent event, Emitter emit) async {
    if (state is ProfileInfoState) {
      var current = state as ProfileInfoState;

      emit(ProfileInfoState(
          personalInfoModel: current.personalInfoModel,
          practicalInfoModel: current.practicalInfoModel,
          professionalInfoModel: event.professionalInfoModel,
          profileInfoModel: current.profileInfoModel,
          page: event.page,
          verificationInfoModel: current.verificationInfoModel));
    } else {
      emit(ProfileInfoState(
          page: event.page,
          professionalInfoModel: event.professionalInfoModel));
    }
  }

  _personalInfo(PersonalInfoEvent event, Emitter emit) async {
    if (state is ProfileInfoState) {
      var current = state as ProfileInfoState;

      emit(ProfileInfoState(
          personalInfoModel: event.personalInfoModel,
          practicalInfoModel: current.practicalInfoModel,
          professionalInfoModel: current.professionalInfoModel,
          profileInfoModel: current.profileInfoModel,
          page: event.page,
          verificationInfoModel: current.verificationInfoModel));
    } else {
      emit(ProfileInfoState(
          page: event.page, personalInfoModel: event.personalInfoModel));
    }
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
