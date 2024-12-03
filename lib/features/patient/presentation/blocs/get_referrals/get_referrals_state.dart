part of 'get_referrals_cubit.dart';

abstract class GetReferralsState extends Equatable {
  const GetReferralsState();

  @override
  List<Object> get props => [];
}

class GetReferralsInitial extends GetReferralsState {}

class GetReferralsLoading extends GetReferralsState {}

class GetReferralsEmpty extends GetReferralsState {}

class GetReferralsSuccess extends GetReferralsState {
  final List<Referral> referrals;

  const GetReferralsSuccess(this.referrals);

  @override
  List<Object> get props => [referrals];
}

class GetReferralsError extends GetReferralsState {
  final String message;

  const GetReferralsError({required this.message});

  @override
  List<Object> get props => [message];
}
