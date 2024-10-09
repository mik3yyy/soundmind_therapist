import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/features/patient/domain/repositories/patient_repository.dart';

class AddUserNote extends UsecaseWithParams<void, AddUserNoteParams> {
  final PatientRepository repository;

  AddUserNote({required this.repository});

  @override
  Future<Either<Failure, void>> call(AddUserNoteParams params) {
    return repository.addUserNote(
      patientId: params.patientId,
      note: params.note,
    );
  }
}

class AddUserNoteParams {
  final int patientId;
  final String note;

  AddUserNoteParams({required this.patientId, required this.note});
}
