import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/request_patients_note.dart';

part 'request_for_patient_notes_state.dart';

class RequestForPatientNotesCubit extends Cubit<RequestForPatientNotesState> {
  final RequestForPatientNotes requestForPatientNotesUseCase;

  RequestForPatientNotesCubit({required this.requestForPatientNotesUseCase})
      : super(RequestForPatientNotesInitial());

  Future<void> requestNotes(int patientId) async {
    emit(RequestForPatientNotesLoading());

    final result = await requestForPatientNotesUseCase.call(patientId);

    result.fold(
      (failure) => emit(RequestForPatientNotesError(message: failure.message)),
      (_) => emit(RequestForPatientNotesSuccess()),
    );
  }
}
