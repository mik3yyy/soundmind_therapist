part of 'create_referral_cubit.dart';

abstract class CreateReferralState extends Equatable {
  const CreateReferralState();

  @override
  List<Object> get props => [];
}

class CreateReferralInitial extends CreateReferralState {}

class CreateReferralLoading extends CreateReferralState {}

class CreateReferralSuccess extends CreateReferralState {}

class CreateReferralError extends CreateReferralState {
  final String message;

  const CreateReferralError({required this.message});

  @override
  List<Object> get props => [message];
}
