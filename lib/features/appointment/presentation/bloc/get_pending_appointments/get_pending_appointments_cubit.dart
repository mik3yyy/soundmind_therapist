import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_pending_appointment.dart';

part 'get_pending_appointments_state.dart';

class GetPendingAppointmentsCubit extends Cubit<GetPendingAppointmentsState> {
  final GetPendingAppointments getPendingAppointmentsUseCase;

  GetPendingAppointmentsCubit({required this.getPendingAppointmentsUseCase})
      : super(GetPendingAppointmentsInitial());

  Future<void> fetchPendingAppointments() async {
    emit(GetPendingAppointmentsLoading());

    final result = await getPendingAppointmentsUseCase.call();

    result.fold(
      (failure) => emit(GetPendingAppointmentsError(message: failure.message)),
      (appointments) => emit(GetPendingAppointmentsSuccess(appointments)),
    );
  }
}
