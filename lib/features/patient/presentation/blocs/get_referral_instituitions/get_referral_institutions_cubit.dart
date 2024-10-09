import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/patient/data/models/referal_inst.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/get_referral_intituition.dart';

part 'get_referral_institutions_state.dart';

class GetReferralInstitutionsCubit extends Cubit<GetReferralInstitutionsState> {
  final GetReferralInstitutions getReferralInstitutionsUseCase;

  GetReferralInstitutionsCubit({required this.getReferralInstitutionsUseCase})
      : super(GetReferralInstitutionsInitial());

  Future<void> fetchInstitutions() async {
    emit(GetReferralInstitutionsLoading());

    final result = await getReferralInstitutionsUseCase.call();

    result.fold(
      (failure) => emit(GetReferralInstitutionsError(message: failure.message)),
      (institutions) => emit(GetReferralInstitutionsSuccess(institutions)),
    );
  }
}
