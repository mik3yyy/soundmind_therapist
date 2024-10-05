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

  final CreateAccount createAccount;
  AuthenticationBloc(
      {required this.login,
      required this.createAccount,
      required this.checkUser})
      : super(AuthenticationInitial()) {
    on<LoginEvent>(onLoginHandler);
    on<CheckUser>(_checkUser);
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
