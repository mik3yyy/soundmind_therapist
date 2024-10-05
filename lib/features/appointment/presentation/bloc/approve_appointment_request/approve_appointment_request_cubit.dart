import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/approve_appointment_request.dart';
part 'approve_appointment_request_state.dart';

class ApproveAppointmentCubit extends Cubit<ApproveAppointmentState> {
  final ApproveAppointmentRequest approveAppointmentRequestUseCase;

  ApproveAppointmentCubit({required this.approveAppointmentRequestUseCase})
      : super(ApproveAppointmentInitial());

  Future<void> approveAppointment(int bookingId) async {
    emit(ApproveAppointmentLoading());

    final result = await approveAppointmentRequestUseCase.call(
      ApproveAppointmentParams(bookingId: bookingId),
    );

    result.fold(
      (failure) => emit(ApproveAppointmentError(message: failure.message)),
      (_) => emit(ApproveAppointmentSuccess()),
    );
  }
}
