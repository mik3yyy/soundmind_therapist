part of 'reject_appointment_request_cubit.dart';

abstract class RejectAppointmentState extends Equatable {
  const RejectAppointmentState();

  @override
  List<Object> get props => [];
}

class RejectAppointmentInitial extends RejectAppointmentState {}

class RejectAppointmentLoading extends RejectAppointmentState {}

class RejectAppointmentSuccess extends RejectAppointmentState {}

class RejectAppointmentError extends RejectAppointmentState {
  final String message;

  const RejectAppointmentError({required this.message});

  @override
  List<Object> get props => [message];
}
