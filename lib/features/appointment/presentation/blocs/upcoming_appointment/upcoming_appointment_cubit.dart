import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/appointment/data/models/appointment.dart';
import 'package:sound_mind/features/appointment/domain/usecases/upcoming_appointment.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/appointment_bloc.dart';

part 'upcoming_appointment_state.dart';

class UpcomingAppointmentCubit extends Cubit<UpcomingAppointmentState> {
  final GetUpcomingAppointments getUpcomingAppointments;

  UpcomingAppointmentCubit({required this.getUpcomingAppointments})
      : super(UpcomingAppointmentInitial());

  Future<void> fetchUpcomingAppointments() async {
    emit(UpcomingAppointmentLoading());

    final result = await getUpcomingAppointments.call();
    result.fold(
      (failure) {
        if (failure.message == "No Upcoming Appointment Found") {
          emit(UpcomingAppointmentEmpty());
        } else {
          emit(UpcomingAppointmentError(message: failure.message));
        }
      },
      (appointments) =>
          emit(UpcomingAppointmentsLoaded(upcomingAppointments: appointments)),
    );
  }
}
