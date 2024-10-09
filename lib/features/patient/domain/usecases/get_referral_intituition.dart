import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/features/patient/data/models/referal_inst.dart';
import 'package:soundmind_therapist/features/patient/domain/repositories/patient_repository.dart';

class GetReferralInstitutions
    extends UsecaseWithoutParams<List<ReferralInstitution>> {
  final PatientRepository repository;

  GetReferralInstitutions({required this.repository});

  @override
  Future<Either<Failure, List<ReferralInstitution>>> call() {
    return repository.getReferralInstitutions();
  }
}
