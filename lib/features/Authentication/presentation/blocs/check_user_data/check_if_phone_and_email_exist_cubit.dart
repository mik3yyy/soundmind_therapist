import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/check_if_phone_and_email_exist.dart';

part 'check_if_phone_and_email_exist_state.dart';

class CheckIfPhoneAndEmailExistCubit
    extends Cubit<CheckIfPhoneAndEmailExistState> {
  final CheckIfPhoneAndEmailExist _checkIfPhoneAndEmailExist;

  CheckIfPhoneAndEmailExistCubit(
      {required CheckIfPhoneAndEmailExist checkIfPhoneAndEmailExist})
      : _checkIfPhoneAndEmailExist = checkIfPhoneAndEmailExist,
        super(CheckIfPhoneAndEmailExistInitial());

  Future<void> checkIfPhoneAndEmailExist(
      String email, String phoneNumber) async {
    emit(CheckIfPhoneAndEmailExistLoading());

    final params =
        CheckIfPhoneAndEmailExistParams(email: email, phoneNumber: phoneNumber);
    final result = await _checkIfPhoneAndEmailExist.call(params);

    result.fold(
        (failure) =>
            emit(CheckIfPhoneAndEmailExistFailure(error: failure.message)),
        (data) {
      if (data['status']) {
        emit(CheckIfPhoneAndEmailExistSuccess(data: data));
      } else {
        emit(CheckIfPhoneAndEmailExistFailure(error: data['message']));
      }
    });
  }
}
