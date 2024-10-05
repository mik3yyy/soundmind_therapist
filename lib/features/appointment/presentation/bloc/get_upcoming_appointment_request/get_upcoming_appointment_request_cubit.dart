import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_appointment_request.dart';

part 'get_upcoming_appointment_request_state.dart';

class GetUpcomingAppointmentRequestCubit
    extends Cubit<GetUpcomingAppointmentRequestState> {
  final GetUpcomingAppointmentRequest getUpcomingAppointmentRequestUseCase;

  GetUpcomingAppointmentRequestCubit(
      {required this.getUpcomingAppointmentRequestUseCase})
      : super(GetUpcomingAppointmentRequestInitial());

  Future<void> fetchUpcomingAppointmentRequests() async {
    emit(GetUpcomingAppointmentRequestLoading());

    final result = await getUpcomingAppointmentRequestUseCase.call();

    result.fold(
      (failure) =>
          emit(GetUpcomingAppointmentRequestError(message: failure.message)),
      (appointments) =>
          emit(GetUpcomingAppointmentRequestSuccess(appointments)),
    );
  }
}
