import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/get_appointment_data.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';


class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final GetAppointmentData getAppointmentData;

  AppointmentBloc({
  required this.getAppointmentData
  }) : super(AppointmentInitial());

}
