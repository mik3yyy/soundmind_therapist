import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';
import 'package:soundmind_therapist/features/appointment/domain/repositories/appointment_repository.dart';

class ApproveAppointmentRequest
    extends UsecaseWithParams<void, ApproveAppointmentParams> {
  final AppointmentRepository _repository;

  ApproveAppointmentRequest({required AppointmentRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, void>> call(ApproveAppointmentParams params) {
    return _repository.approveAppointmentRequest(bookingId: params.bookingId);
  }
}

class ApproveAppointmentParams {
  final int bookingId;

  ApproveAppointmentParams({required this.bookingId});
}
