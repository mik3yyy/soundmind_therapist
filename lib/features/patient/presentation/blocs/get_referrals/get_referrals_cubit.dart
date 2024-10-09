import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/patient/data/models/referral.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/get_referral.dart';

part 'get_referrals_state.dart';

class GetReferralsCubit extends Cubit<GetReferralsState> {
  final GetReferrals getReferralsUseCase;

  GetReferralsCubit({required this.getReferralsUseCase})
      : super(GetReferralsInitial());

  Future<void> fetchReferrals() async {
    emit(GetReferralsLoading());

    final result = await getReferralsUseCase.call();

    result.fold(
      (failure) => emit(GetReferralsError(message: failure.message)),
      (referrals) => emit(GetReferralsSuccess(referrals)),
    );
  }
}
