part of 'finalize_booking_cubit.dart';

sealed class FinalizeBookingState extends Equatable {
  const FinalizeBookingState();

  @override
  List<Object> get props => [];
}

final class FinalizeBookingInitial extends FinalizeBookingState {}

class FinalizeBookingLoading extends FinalizeBookingState {}

class FinalizeBookingSuccess extends FinalizeBookingState {}

class FinalizeBookingError extends FinalizeBookingState {
  final String message;

  const FinalizeBookingError({required this.message});

  @override
  List<Object> get props => [message];
}
