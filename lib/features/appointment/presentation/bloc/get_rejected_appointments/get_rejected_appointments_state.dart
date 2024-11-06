part of 'get_rejected_appointments_cubit.dart';

abstract class GetRejectedAppointmentsState extends Equatable {
  const GetRejectedAppointmentsState();

  @override
  List<Object> get props => [];
}

class GetRejectedAppointmentsInitial extends GetRejectedAppointmentsState {}

class GetRejectedAppointmentsLoading extends GetRejectedAppointmentsState {}

class GetRejectedAppointmentsSuccess extends GetRejectedAppointmentsState {
  final List<AppointmentModel> appointments;

  const GetRejectedAppointmentsSuccess(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class GetRejectedAppointmentsError extends GetRejectedAppointmentsState {
  final String message;

  const GetRejectedAppointmentsError({required this.message});

  @override
  List<Object> get props => [message];
}
