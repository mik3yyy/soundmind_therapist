part of 'get_referral_institutions_cubit.dart';

abstract class GetReferralInstitutionsState extends Equatable {
  const GetReferralInstitutionsState();

  @override
  List<Object> get props => [];
}

class GetReferralInstitutionsInitial extends GetReferralInstitutionsState {}

class GetReferralInstitutionsLoading extends GetReferralInstitutionsState {}

class GetReferralInstitutionsSuccess extends GetReferralInstitutionsState {
  final List<ReferralInstitution> institutions;

  const GetReferralInstitutionsSuccess(this.institutions);

  @override
  List<Object> get props => [institutions];
}

class GetReferralInstitutionsError extends GetReferralInstitutionsState {
  final String message;

  const GetReferralInstitutionsError({required this.message});

  @override
  List<Object> get props => [message];
}
