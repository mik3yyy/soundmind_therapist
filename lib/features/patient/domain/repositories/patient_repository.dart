import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/features/patient/data/models/chat_message.dart';
import 'package:soundmind_therapist/features/patient/data/models/chat_room.dart';
import 'package:soundmind_therapist/features/patient/data/models/patient_model.dart';
import 'package:soundmind_therapist/features/patient/data/models/referal_inst.dart';
import 'package:soundmind_therapist/features/patient/data/models/referral.dart';

abstract class PatientRepository {
  // Define abstract methods here
  Future<Either<Failure, void>> addUserNote({
    required int patientId,
    required String note,
  });

  Future<Either<Failure, PatientModel>> getPatientDetails({
    required int patientId,
  });

  Future<Either<Failure, void>> requestForPatientNotes({
    required int patientId,
  });

  Future<Either<Failure, List<ChatRoom>>> getUserChatRooms();

  Future<Either<Failure, List<ChatMessage>>> getUserChatRoomMessages({
    required int chatRoomId,
  });

  Future<Either<Failure, List<ReferralInstitution>>> getReferralInstitutions();

  Future<Either<Failure, List<Referral>>> getReferrals();

  Future<Either<Failure, void>> createReferral({
    required int patientId,
    required int institutionId,
    required String notes,
  });
}
