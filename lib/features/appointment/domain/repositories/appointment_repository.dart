import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';

import '../../../../core/error/failures.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, AppointmentModel>> getUpcomingAppointments();

  Future<Either<Failure, List<AppointmentModel>>>
      getUpcomingAppointmentRequest();

  Future<Either<Failure, List<Booking>>> getAcceptedAppointments();

  Future<Either<Failure, List<Booking>>> getPendingAppointments();

  Future<Either<Failure, List<Booking>>> getRejectedAppointments();

  Future<Either<Failure, void>> approveAppointmentRequest(
      {required int bookingId});

  Future<Either<Failure, void>> rejectAppointmentRequest(
      {required int bookingId});

  Future<Either<Failure, AppointmentModel>> getCachedUpcomingAppointments();

  Future<Either<Failure, void>> deleteCachedAppointments();
}
