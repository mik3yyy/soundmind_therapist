import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/finalize_booking.dart';

part 'finalize_booking_state.dart';

class FinalizeBookingCubit extends Cubit<FinalizeBookingState> {
  final FinalizeBookingUsecase finalizeBookingUsecase;
  FinalizeBookingCubit({required this.finalizeBookingUsecase})
      : super(FinalizeBookingInitial());

  Future<void> finalizeBooking({required int id, required String code}) async {
    emit(FinalizeBookingLoading());

    final result = await finalizeBookingUsecase
        .call(FinalizeBookingParams(bookingId: id, code: code));

    result.fold(
      (failure) => emit(FinalizeBookingError(message: failure.message)),
      (appointments) => emit(FinalizeBookingSuccess()),
    );
  }
}

  // final GetPendingAppointments getPendingAppointmentsUseCase;

  // GetPendingAppointmentsCubit({required this.getPendingAppointmentsUseCase})
  //     : super(GetPendingAppointmentsInitial());

  // Future<void> fetchPendingAppointments() async {
  //   emit(GetPendingAppointmentsLoading());

  //   final result = await getPendingAppointmentsUseCase.call();

  //   result.fold(
  //     (failure) => emit(GetPendingAppointmentsError(message: failure.message)),
  //     (appointments) => emit(GetPendingAppointmentsSuccess(appointments)),
  //   );
  // }