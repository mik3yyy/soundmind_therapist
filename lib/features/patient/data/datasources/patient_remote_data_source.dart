import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:soundmind_therapist/core/network/network.dart';
import 'package:soundmind_therapist/features/patient/data/models/chat_message.dart';
import 'package:soundmind_therapist/features/patient/data/models/chat_room.dart';
import 'package:soundmind_therapist/features/patient/data/models/patient_model.dart';
import 'package:soundmind_therapist/features/patient/data/models/referal_inst.dart';
import 'package:soundmind_therapist/features/patient/data/models/referral.dart';

abstract class PatientRemoteDataSource {
  Future<void> addUserNote({
    required int patientId,
    required String note,
  });

  Future<PatientModel> getPatientDetails({required int patientId});

  Future<void> requestForPatientNotes({required int patientId});

  Future<List<ChatRoom>> getUserChatRooms();

  Future<List<ChatMessage>> getUserChatRoomMessages({required int chatRoomId});

  Future<List<ReferralInstitution>> getReferralInstitutions();

  Future<List<Referral>> getReferrals();

  Future<void> createReferral({
    required int patientId,
    required int institutionId,
    required String notes,
  });
}

class PatientRemoteDataSourceImpl extends PatientRemoteDataSource {
  final Network _network;

  PatientRemoteDataSourceImpl({required Network network}) : _network = network;

  @override
  Future<void> addUserNote({
    required int patientId,
    required String note,
  }) async {
    await _network.call(
      '/TherapistDashboard/AddUserNote',
      RequestMethod.post,
      data: {
        'patientId': patientId,
        'note': note,
        'Message': note,
      },
    );
  }

  @override
  Future<PatientModel> getPatientDetails({required int patientId}) async {
    Response response = await _network.call(
      '/TherapistDashboard/GetPatientDetails/$patientId',
      RequestMethod.patch,
    );
    print(response.data['data']);
    return PatientModel.fromJson(response.data['data']);
  }

  @override
  Future<void> requestForPatientNotes({required int patientId}) async {
    await _network.call(
      '/TherapistDashboard/RequestForPatientNotes/$patientId',
      RequestMethod.patch,
    );
  }

  @override
  Future<List<ChatRoom>> getUserChatRooms() async {
    Response response = await _network.call(
      '/TherapistDashboard/GetUserChatRooms',
      RequestMethod.get,
    );
    return (response.data['data'] as List).map((json) => ChatRoom.fromJson(json)).toList();
  }

  @override
  Future<List<ChatMessage>> getUserChatRoomMessages({required int chatRoomId}) async {
    Response response = await _network.call(
      '/TherapistDashboard/GetUserChatRoomMessages?ChatroomID=$chatRoomId',
      RequestMethod.get,
    );
    return (response.data['data'] as List).map((json) => ChatMessage.fromJson(json)).toList();
  }

  @override
  Future<List<ReferralInstitution>> getReferralInstitutions() async {
    Response response = await _network.call(
      '/Referral/GetReferralInstitutions',
      RequestMethod.get,
    );
    return (response.data['data'] as List).map((json) => ReferralInstitution.fromJson(json)).toList();
  }

  @override
  Future<List<Referral>> getReferrals() async {
    Response response = await _network.call(
      '/Referral/GetReferrals',
      RequestMethod.get,
    );
    print("RESPONSE" + response.data.toString());
    return (response.data['data'] as List).map((json) => Referral.fromJson(json)).toList();
  }

  @override
  Future<void> createReferral({
    required int patientId,
    required int institutionId,
    required String notes,
  }) async {
    await _network.call(
      '/Referral/CreateReferral',
      RequestMethod.post,
      data: {
        'patientId': patientId,
        'institution': institutionId,
        // 'pharmacyInstitution': int.parse(notes),
      },
    );
  }
}
