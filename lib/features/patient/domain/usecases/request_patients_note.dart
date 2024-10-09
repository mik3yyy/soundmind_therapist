import 'package:dartz/dartz.dart';

import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/features/patient/domain/repositories/patient_repository.dart';

class RequestForPatientNotes extends UsecaseWithParams<void, int> {
  final PatientRepository repository;

  RequestForPatientNotes({required this.repository});

  @override
  Future<Either<Failure, void>> call(int patientId) {
    return repository.requestForPatientNotes(patientId: patientId);
  }
}
