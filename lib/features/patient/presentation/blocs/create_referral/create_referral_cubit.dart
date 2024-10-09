import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/create_referal.dart';

part 'create_referral_state.dart';

class CreateReferralCubit extends Cubit<CreateReferralState> {
  final CreateReferral createReferralUseCase;

  CreateReferralCubit({required this.createReferralUseCase})
      : super(CreateReferralInitial());

  Future<void> createReferral({
    required int patientId,
    required int institutionId,
    required String notes,
  }) async {
    emit(CreateReferralLoading());

    final result = await createReferralUseCase.call(
      CreateReferralParams(
        patientId: patientId,
        institutionId: institutionId,
        notes: notes,
      ),
    );

    result.fold(
      (failure) => emit(CreateReferralError(message: failure.message)),
      (_) => emit(CreateReferralSuccess()),
    );
  }
}
