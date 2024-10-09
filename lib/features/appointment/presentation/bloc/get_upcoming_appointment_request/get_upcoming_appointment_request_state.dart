part of 'get_upcoming_appointment_request_cubit.dart';

abstract class GetUpcomingAppointmentRequestState extends Equatable {
  const GetUpcomingAppointmentRequestState();

  @override
  List<Object> get props => [];
}

class GetUpcomingAppointmentRequestInitial
    extends GetUpcomingAppointmentRequestState {}

class GetUpcomingAppointmentRequestLoading
    extends GetUpcomingAppointmentRequestState {}

class GetUpcomingAppointmentRequestSuccess
    extends GetUpcomingAppointmentRequestState {
  final AppointmentModel appointments;

  const GetUpcomingAppointmentRequestSuccess(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class GetUpcomingAppointmentRequestError
    extends GetUpcomingAppointmentRequestState {
  final String message;

  const GetUpcomingAppointmentRequestError({required this.message});

  @override
  List<Object> get props => [message];
}
