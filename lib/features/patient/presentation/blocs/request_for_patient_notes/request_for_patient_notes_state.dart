part of 'request_for_patient_notes_cubit.dart';

abstract class RequestForPatientNotesState extends Equatable {
  const RequestForPatientNotesState();

  @override
  List<Object> get props => [];
}

class RequestForPatientNotesInitial extends RequestForPatientNotesState {}

class RequestForPatientNotesLoading extends RequestForPatientNotesState {}

class RequestForPatientNotesSuccess extends RequestForPatientNotesState {}

class RequestForPatientNotesError extends RequestForPatientNotesState {
  final String message;

  const RequestForPatientNotesError({required this.message});

  @override
  List<Object> get props => [message];
}
