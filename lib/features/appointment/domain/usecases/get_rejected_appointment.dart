import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';
import 'package:soundmind_therapist/features/appointment/domain/repositories/appointment_repository.dart';

class GetRejectedAppointments extends UsecaseWithoutParams<List<Booking>> {
  final AppointmentRepository _repository;

  GetRejectedAppointments({required AppointmentRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<Booking>>> call() {
    return _repository.getRejectedAppointments();
  }
}
