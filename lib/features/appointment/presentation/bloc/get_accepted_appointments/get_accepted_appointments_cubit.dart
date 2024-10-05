import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_accepted_request.dart';

part 'get_accepted_appointments_state.dart';

class GetAcceptedAppointmentsCubit extends Cubit<GetAcceptedAppointmentsState> {
  final GetAcceptedAppointments getAcceptedAppointmentsUseCase;

  GetAcceptedAppointmentsCubit({required this.getAcceptedAppointmentsUseCase})
      : super(GetAcceptedAppointmentsInitial());

  Future<void> fetchAcceptedAppointments() async {
    emit(GetAcceptedAppointmentsLoading());

    final result = await getAcceptedAppointmentsUseCase.call();

    result.fold(
      (failure) => emit(GetAcceptedAppointmentsError(message: failure.message)),
      (appointments) => emit(GetAcceptedAppointmentsSuccess(appointments)),
    );
  }
}
