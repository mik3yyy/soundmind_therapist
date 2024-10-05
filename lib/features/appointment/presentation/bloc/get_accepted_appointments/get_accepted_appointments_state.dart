part of 'get_accepted_appointments_cubit.dart';

abstract class GetAcceptedAppointmentsState extends Equatable {
  const GetAcceptedAppointmentsState();

  @override
  List<Object> get props => [];
}

class GetAcceptedAppointmentsInitial extends GetAcceptedAppointmentsState {}

class GetAcceptedAppointmentsLoading extends GetAcceptedAppointmentsState {}

class GetAcceptedAppointmentsSuccess extends GetAcceptedAppointmentsState {
  final List<Booking> appointments;

  const GetAcceptedAppointmentsSuccess(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class GetAcceptedAppointmentsError extends GetAcceptedAppointmentsState {
  final String message;

  const GetAcceptedAppointmentsError({required this.message});

  @override
  List<Object> get props => [message];
}
