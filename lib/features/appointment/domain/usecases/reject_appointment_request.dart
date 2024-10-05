import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';
import 'package:soundmind_therapist/features/appointment/domain/repositories/appointment_repository.dart';

class RejectAppointmentRequest
    extends UsecaseWithParams<void, RejectAppointmentParams> {
  final AppointmentRepository _repository;

  RejectAppointmentRequest({required AppointmentRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, void>> call(RejectAppointmentParams params) {
    return _repository.rejectAppointmentRequest(bookingId: params.bookingId);
  }
}

class RejectAppointmentParams {
  final int bookingId;

  RejectAppointmentParams({required this.bookingId});
}
