import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';
import 'package:soundmind_therapist/features/appointment/domain/repositories/appointment_repository.dart';

class FinalizeBookingUsecase
    extends UsecaseWithParams<void, FinalizeBookingParams> {
  final AppointmentRepository _repository;

  FinalizeBookingUsecase({required AppointmentRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, void>> call(FinalizeBookingParams params) {
    return _repository.finalizeBooking(
        bookingId: params.bookingId, code: params.code);
  }
}

class FinalizeBookingParams {
  final int bookingId;
  final String code;

  FinalizeBookingParams({required this.bookingId, required this.code});
}
