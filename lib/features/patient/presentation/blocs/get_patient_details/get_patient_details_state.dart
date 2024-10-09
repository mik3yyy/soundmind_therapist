part of 'get_patient_details_cubit.dart';

abstract class GetPatientDetailsState extends Equatable {
  const GetPatientDetailsState();

  @override
  List<Object> get props => [];
}

class GetPatientDetailsInitial extends GetPatientDetailsState {}

class GetPatientDetailsLoading extends GetPatientDetailsState {}

class GetPatientDetailsSuccess extends GetPatientDetailsState {
  final PatientModel patient;

  const GetPatientDetailsSuccess(this.patient);

  @override
  List<Object> get props => [patient];
}

class GetPatientDetailsError extends GetPatientDetailsState {
  final String message;

  const GetPatientDetailsError({required this.message});

  @override
  List<Object> get props => [message];
}
