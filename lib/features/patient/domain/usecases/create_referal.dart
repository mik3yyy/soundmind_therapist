import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/features/patient/domain/repositories/patient_repository.dart';

class CreateReferral extends UsecaseWithParams<void, CreateReferralParams> {
  final PatientRepository repository;

  CreateReferral({required this.repository});

  @override
  Future<Either<Failure, void>> call(CreateReferralParams params) {
    return repository.createReferral(
      patientId: params.patientId,
      institutionId: params.institutionId,
      notes: params.notes,
    );
  }
}

class CreateReferralParams {
  final int patientId;
  final int institutionId;
  final String notes;

  CreateReferralParams({
    required this.patientId,
    required this.institutionId,
    required this.notes,
  });
}
