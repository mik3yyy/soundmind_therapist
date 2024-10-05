part of 'approve_appointment_request_cubit.dart';

abstract class ApproveAppointmentState extends Equatable {
  const ApproveAppointmentState();

  @override
  List<Object> get props => [];
}

class ApproveAppointmentInitial extends ApproveAppointmentState {}

class ApproveAppointmentLoading extends ApproveAppointmentState {}

class ApproveAppointmentSuccess extends ApproveAppointmentState {}

class ApproveAppointmentError extends ApproveAppointmentState {
  final String message;

  const ApproveAppointmentError({required this.message});

  @override
  List<Object> get props => [message];
}
