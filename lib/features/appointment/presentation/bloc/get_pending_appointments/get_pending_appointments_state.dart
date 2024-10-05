part of 'get_pending_appointments_cubit.dart';

abstract class GetPendingAppointmentsState extends Equatable {
  const GetPendingAppointmentsState();

  @override
  List<Object> get props => [];
}

class GetPendingAppointmentsInitial extends GetPendingAppointmentsState {}

class GetPendingAppointmentsLoading extends GetPendingAppointmentsState {}

class GetPendingAppointmentsSuccess extends GetPendingAppointmentsState {
  final List<Booking> appointments;

  const GetPendingAppointmentsSuccess(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class GetPendingAppointmentsError extends GetPendingAppointmentsState {
  final String message;

  const GetPendingAppointmentsError({required this.message});

  @override
  List<Object> get props => [message];
}
