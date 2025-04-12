part of 'get_upcoming_appointments_cubit.dart';

abstract class GetUpcomingAppointmentsState extends Equatable {
  const GetUpcomingAppointmentsState();

  @override
  List<Object> get props => [];
}

class GetUpcomingAppointmentsInitial extends GetUpcomingAppointmentsState {}

class GetUpcomingAppointmentsLoading extends GetUpcomingAppointmentsState {}

class GetUpcomingAppointmentsSuccess extends GetUpcomingAppointmentsState {
  final List<AppointmentModel> appointments;

  const GetUpcomingAppointmentsSuccess(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class GetUpcomingAppointmentsError extends GetUpcomingAppointmentsState {
  final String message;

  const GetUpcomingAppointmentsError({required this.message});

  @override
  List<Object> get props => [message];
}
