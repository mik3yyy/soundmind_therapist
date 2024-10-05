import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/reject_appointment_request.dart';

part 'reject_appointment_request_state.dart';

class RejectAppointmentCubit extends Cubit<RejectAppointmentState> {
  final RejectAppointmentRequest rejectAppointmentRequestUseCase;

  RejectAppointmentCubit({required this.rejectAppointmentRequestUseCase})
      : super(RejectAppointmentInitial());

  Future<void> rejectAppointment(int bookingId) async {
    emit(RejectAppointmentLoading());

    final result = await rejectAppointmentRequestUseCase.call(
      RejectAppointmentParams(bookingId: bookingId),
    );

    result.fold(
      (failure) => emit(RejectAppointmentError(message: failure.message)),
      (_) => emit(RejectAppointmentSuccess()),
    );
  }
}
