import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';
import 'package:soundmind_therapist/features/appointment/domain/repositories/appointment_repository.dart';

class GetPendingAppointments
    extends UsecaseWithoutParams<List<AppointmentModel>> {
  final AppointmentRepository _repository;

  GetPendingAppointments({required AppointmentRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<AppointmentModel>>> call() {
    return _repository.getPendingAppointments();
  }
}
