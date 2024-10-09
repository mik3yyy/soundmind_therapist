import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/features/patient/data/models/chat_room.dart';
import 'package:soundmind_therapist/features/patient/domain/repositories/patient_repository.dart';

class GetUserChatRooms extends UsecaseWithoutParams<List<ChatRoom>> {
  final PatientRepository repository;

  GetUserChatRooms({required this.repository});

  @override
  Future<Either<Failure, List<ChatRoom>>> call() {
    return repository.getUserChatRooms();
  }
}
