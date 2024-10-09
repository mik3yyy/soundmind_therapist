import 'package:dartz/dartz.dart';
import '../entities/patient_entity.dart';
import '../repositories/patient_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';

import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/features/patient/data/models/patient_model.dart';
import 'package:soundmind_therapist/features/patient/domain/repositories/patient_repository.dart';

class GetPatientData {
  final PatientRepository repository;

  GetPatientData({required this.repository});

  // Implement call method here
}

class GetPatientDetails extends UsecaseWithParams<PatientModel, int> {
  final PatientRepository repository;

  GetPatientDetails({required this.repository});

  @override
  Future<Either<Failure, PatientModel>> call(int patientId) {
    return repository.getPatientDetails(patientId: patientId);
  }
}
