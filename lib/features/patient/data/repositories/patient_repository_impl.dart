import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/network/network.dart';
import 'package:soundmind_therapist/features/patient/data/datasources/patient_hive_data_source.dart';
import 'package:soundmind_therapist/features/patient/data/datasources/patient_remote_data_source.dart';
import 'package:soundmind_therapist/features/patient/data/models/chat_message.dart';
import 'package:soundmind_therapist/features/patient/data/models/chat_room.dart';
import 'package:soundmind_therapist/features/patient/data/models/patient_model.dart';
import 'package:soundmind_therapist/features/patient/data/models/referal_inst.dart';
import 'package:soundmind_therapist/features/patient/data/models/referral.dart';
import 'package:soundmind_therapist/features/patient/domain/repositories/patient_repository.dart';

class PatientRepositoryImpl extends PatientRepository {
  final PatientRemoteDataSource _remoteDataSource;
  final PatientHiveDataSource _hiveDataSource;

  PatientRepositoryImpl(
      {required PatientRemoteDataSource remoteDataSource,
      required PatientHiveDataSource hiveDataSource})
      : _remoteDataSource = remoteDataSource,
        _hiveDataSource = hiveDataSource;

  @override
  Future<Either<Failure, void>> addUserNote({
    required int patientId,
    required String note,
  }) async {
    try {
      await _remoteDataSource.addUserNote(
        patientId: patientId,
        note: note,
      );
      return Right(null);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  Future<Either<Failure, PatientModel>> getPatientDetails(
      {required int patientId}) async {
    try {
      final response = await _remoteDataSource.getPatientDetails(
        patientId: patientId,
      );
      return Right(response);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  Future<Either<Failure, void>> requestForPatientNotes(
      {required int patientId}) async {
    try {
      await _remoteDataSource.requestForPatientNotes(patientId: patientId);
      return Right(null);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  Future<Either<Failure, List<ChatRoom>>> getUserChatRooms() async {
    try {
      final response = await _remoteDataSource.getUserChatRooms();
      return Right(response);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessage>>> getUserChatRoomMessages(
      {required int chatRoomId}) async {
    try {
      final response = await _remoteDataSource.getUserChatRoomMessages(
          chatRoomId: chatRoomId);
      return Right(response);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  Future<Either<Failure, List<ReferralInstitution>>>
      getReferralInstitutions() async {
    try {
      final response = await _remoteDataSource.getReferralInstitutions();
      return Right(response);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  Future<Either<Failure, List<Referral>>> getReferrals() async {
    try {
      final response = await _remoteDataSource.getReferrals();
      return Right(response);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  Future<Either<Failure, void>> createReferral({
    required int patientId,
    required int institutionId,
    required String notes,
  }) async {
    try {
      await _remoteDataSource.createReferral(
        patientId: patientId,
        institutionId: institutionId,
        notes: notes,
      );
      return Right(null);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }
}
