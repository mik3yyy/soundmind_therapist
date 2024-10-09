import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/features/patient/data/models/referral.dart';
import 'package:soundmind_therapist/features/patient/domain/repositories/patient_repository.dart';

class GetReferrals extends UsecaseWithoutParams<List<Referral>> {
  final PatientRepository repository;

  GetReferrals({required this.repository});

  @override
  Future<Either<Failure, List<Referral>>> call() {
    return repository.getReferrals();
  }
}
