import 'package:dartz/dartz.dart';

import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/features/patient/data/models/chat_message.dart';
import 'package:soundmind_therapist/features/patient/domain/repositories/patient_repository.dart';

class GetUserChatRoomMessages
    extends UsecaseWithParams<List<ChatMessage>, int> {
  final PatientRepository repository;

  GetUserChatRoomMessages({required this.repository});

  @override
  Future<Either<Failure, List<ChatMessage>>> call(int chatRoomId) {
    return repository.getUserChatRoomMessages(chatRoomId: chatRoomId);
  }
}
