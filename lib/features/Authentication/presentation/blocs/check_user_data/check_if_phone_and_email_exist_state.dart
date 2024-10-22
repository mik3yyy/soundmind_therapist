part of 'check_if_phone_and_email_exist_cubit.dart';

abstract class CheckIfPhoneAndEmailExistState extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckIfPhoneAndEmailExistInitial extends CheckIfPhoneAndEmailExistState {}

class CheckIfPhoneAndEmailExistLoading extends CheckIfPhoneAndEmailExistState {}

class CheckIfPhoneAndEmailExistSuccess extends CheckIfPhoneAndEmailExistState {
  final DataMap data;

  CheckIfPhoneAndEmailExistSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class CheckIfPhoneAndEmailExistFailure extends CheckIfPhoneAndEmailExistState {
  final String error;

  CheckIfPhoneAndEmailExistFailure({required this.error});

  @override
  List<Object> get props => [error];
}
