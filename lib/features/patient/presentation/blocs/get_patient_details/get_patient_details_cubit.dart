import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/patient/data/models/patient_model.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/get_patient_data.dart';

part 'get_patient_details_state.dart';

class GetPatientDetailsCubit extends Cubit<GetPatientDetailsState> {
  final GetPatientDetails getPatientDetailsUseCase;

  GetPatientDetailsCubit({required this.getPatientDetailsUseCase})
      : super(GetPatientDetailsInitial());

  Future<void> fetchPatientDetails(int patientId) async {
    emit(GetPatientDetailsLoading());

    final result = await getPatientDetailsUseCase.call(patientId);

    result.fold(
      (failure) => emit(GetPatientDetailsError(message: failure.message)),
      (patient) => emit(GetPatientDetailsSuccess(patient)),
    );
  }
}
