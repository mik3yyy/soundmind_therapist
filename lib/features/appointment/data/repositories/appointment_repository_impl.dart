import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/network/network.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/appointment/data/datasources/appointment_hive_data_source.dart';
import 'package:soundmind_therapist/features/appointment/data/datasources/appointment_remote_data_source.dart';
import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';
import 'package:soundmind_therapist/features/appointment/data/models/metrics_model.dart';
import 'package:soundmind_therapist/features/appointment/domain/repositories/appointment_repository.dart';

class AppointmentRepositoryImpl extends AppointmentRepository {
  final AppointmentRemoteDataSource _remoteDataSource;
  final AppointmentHiveDataSource _hiveDataSource;

  AppointmentRepositoryImpl({
    required AppointmentRemoteDataSource remoteDataSource,
    required AppointmentHiveDataSource hiveDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _hiveDataSource = hiveDataSource;

  @override
  ResultFuture<AppointmentModel> getUpcomingAppointments() async {
    try {
      final response = await _remoteDataSource.getUpcomingAppointments();
      AppointmentModel appointment = AppointmentModel.fromJson(response);
      await _hiveDataSource.saveUpcomingAppointments(appointment: appointment);
      return Right(appointment);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  Future<Either<Failure, void>> finalizeBooking(
      {required int bookingId, required String code}) async {
    try {
      await _remoteDataSource.finalizeBooking(bookingId: bookingId, code: code);
      return Right(null);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<AppointmentModel> getUpcomingAppointmentRequest() async {
    try {
      final response = await _remoteDataSource.getUpcomingAppointmentRequest();
      print(response);
      AppointmentModel appointment =
          AppointmentModel.fromJson(response['data']);
      return Right(appointment);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<MetricsModel> getUserMetrics() async {
    try {
      final response = await _remoteDataSource.getUserMetrics();
      print(response);
      MetricsModel metrics = MetricsModel.fromJson(response['data']);
      print("-----------");
      return Right(metrics);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<List<AppointmentModel>> getAcceptedAppointments() async {
    try {
      final response = await _remoteDataSource.getAcceptedAppointments();
      print(response);
      List<AppointmentModel> appointments = (response['data'] as List)
          .map((json) => AppointmentModel.fromJson(json))
          .toList();
      return Right(appointments);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<List<AppointmentModel>> getPendingAppointments() async {
    try {
      final response = await _remoteDataSource.getPendingAppointments();
      print(response);
      List<AppointmentModel> appointments = (response['data'] as List)
          .map((json) => AppointmentModel.fromJson(json))
          .toList();
      return Right(appointments);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<List<AppointmentModel>> getRejectedAppointments() async {
    try {
      final response = await _remoteDataSource.getRejectedAppointments();
      List<AppointmentModel> appointments = (response['data'] as List)
          .map((json) => AppointmentModel.fromJson(json))
          .toList();
      return Right(appointments);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<void> approveAppointmentRequest({required int bookingId}) async {
    try {
      await _remoteDataSource.approveAppointmentRequest(bookingId: bookingId);
      return Right(null);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<void> rejectAppointmentRequest({required int bookingId}) async {
    try {
      await _remoteDataSource.rejectAppointmentRequest(bookingId: bookingId);
      return Right(null);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<AppointmentModel> getCachedUpcomingAppointments() async {
    try {
      final appointments = await _hiveDataSource.getUpcomingAppointments();
      if (appointments != null) {
        return Right(appointments);
      } else {
        return const Left(CacheFailure("No cached appointments found"));
      }
    } catch (e) {
      return const Left(CacheFailure("No cached appointments found"));
    }
  }

  @override
  ResultFuture<void> deleteCachedAppointments() async {
    try {
      await _hiveDataSource.deleteAppointments();
      return Right(null);
    } catch (e) {
      return const Left(CacheFailure("Error deleting cached appointments"));
    }
  }

  @override
  Future<Either<Failure, void>> approveAppointment() {
    // TODO: implement approveAppointment
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> rejectAppointment() {
    // TODO: implement rejectAppointment
    throw UnimplementedError();
  }
}
