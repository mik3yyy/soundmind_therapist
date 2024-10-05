import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_rejected_appointment.dart';

part 'get_rejected_appointments_state.dart';

class GetRejectedAppointmentsCubit extends Cubit<GetRejectedAppointmentsState> {
  final GetRejectedAppointments getRejectedAppointmentsUseCase;

  GetRejectedAppointmentsCubit({required this.getRejectedAppointmentsUseCase})
      : super(GetRejectedAppointmentsInitial());

  Future<void> fetchRejectedAppointments() async {
    emit(GetRejectedAppointmentsLoading());

    final result = await getRejectedAppointmentsUseCase.call();

    result.fold(
      (failure) => emit(GetRejectedAppointmentsError(message: failure.message)),
      (appointments) => emit(GetRejectedAppointmentsSuccess(appointments)),
    );
  }
}
