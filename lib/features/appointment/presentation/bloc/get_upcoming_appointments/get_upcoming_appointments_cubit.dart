import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_upcoming_appointment.dart';

part 'get_upcoming_appointments_state.dart';

class GetUpcomingAppointmentsCubit extends Cubit<GetUpcomingAppointmentsState> {
  final GetUpcomingAppointments getUpcomingAppointmentsUseCase;

  GetUpcomingAppointmentsCubit({required this.getUpcomingAppointmentsUseCase})
      : super(GetUpcomingAppointmentsInitial());

  Future<void> fetchUpcomingAppointments() async {
    emit(GetUpcomingAppointmentsLoading());

    final result = await getUpcomingAppointmentsUseCase.call();

    result.fold(
      (failure) => emit(GetUpcomingAppointmentsError(message: failure.message)),
      (appointments) => emit(GetUpcomingAppointmentsSuccess(appointments)),
    );
  }
}
