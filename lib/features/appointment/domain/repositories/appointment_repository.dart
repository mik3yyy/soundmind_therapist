import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';
import 'package:soundmind_therapist/features/appointment/data/models/metrics_model.dart';

import '../../../../core/error/failures.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, List<AppointmentModel>>> getUpcomingAppointments();

  Future<Either<Failure, AppointmentModel>> getUpcomingAppointmentRequest();

  Future<Either<Failure, List<AppointmentModel>>> getAcceptedAppointments();

  Future<Either<Failure, List<AppointmentModel>>> getPendingAppointments();

  Future<Either<Failure, List<AppointmentModel>>> getRejectedAppointments();

  Future<Either<Failure, void>> approveAppointmentRequest(
      {required int bookingId});

  Future<Either<Failure, void>> rejectAppointmentRequest(
      {required int bookingId});
  Future<Either<Failure, void>> finalizeBooking(
      {required int bookingId, required String code});
  Future<Either<Failure, AppointmentModel>> getCachedUpcomingAppointments();

  Future<Either<Failure, void>> deleteCachedAppointments();

  ResultFuture<MetricsModel> getUserMetrics();
}
