import 'package:dio/dio.dart';
import 'package:soundmind_therapist/core/network/network.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';

abstract class AppointmentRemoteDataSource {
  Future<DataMap> getUpcomingAppointments();
  Future<DataMap> getUpcomingAppointmentRequest();
  Future<DataMap> getAcceptedAppointments();
  Future<DataMap> getPendingAppointments();
  Future<DataMap> getRejectedAppointments();
  Future<void> approveAppointmentRequest({required int bookingId});
  Future<void> rejectAppointmentRequest({required int bookingId});

  Future<void> finalizeBooking({required int bookingId, required String code});
  Future<DataMap> getUserMetrics();
}

class AppointmentRemoteDataSourceImpl extends AppointmentRemoteDataSource {
  final Network _network;

  AppointmentRemoteDataSourceImpl({required Network network})
      : _network = network;

  @override
  Future<DataMap> getUpcomingAppointments() async {
    Response response = await _network.call(
      "/TherapistDashboard/GetUpcomingSessions",
      RequestMethod.get,
    );
    print(response.data['data']);
    return response.data;
  }

  @override
  Future<DataMap> getUpcomingAppointmentRequest() async {
    Response response = await _network.call(
      "/TherapistDashboard/GetUpcomingAppointmentRequest",
      RequestMethod.get,
    );
    return response.data;
  }

  @override
  Future<DataMap> getUserMetrics() async {
    Response response = await _network.call(
      "/TherapistDashboard/GetUserMetrics",
      RequestMethod.get,
    );
    return response.data;
  }

  @override
  Future<DataMap> getAcceptedAppointments() async {
    Response response = await _network.call(
      "/TherapistDashboard/GetAcceptedAppointments",
      RequestMethod.get,
    );
    return response.data;
  }

  @override
  Future<DataMap> getPendingAppointments() async {
    Response response = await _network.call(
      "/TherapistDashboard/GetPendingAppointments",
      RequestMethod.get,
    );
    return response.data;
  }

  @override
  Future<DataMap> getRejectedAppointments() async {
    Response response = await _network.call(
      "/TherapistDashboard/GetRejectedAppointments",
      RequestMethod.get,
    );
    return response.data;
  }

  @override
  Future<void> approveAppointmentRequest({required int bookingId}) async {
    await _network.call(
      "/TherapistDashboard/ApproveAppointmentRequest/$bookingId",
      RequestMethod.patch,
    );
  }

  @override
  Future<void> rejectAppointmentRequest({required int bookingId}) async {
    await _network.call(
      "/TherapistDashboard/RejectAppointmentRequest/$bookingId",
      RequestMethod.patch,
    );
  }

  @override
  Future<void> finalizeBooking(
      {required int bookingId, required String code}) async {
    Response response = await _network.call(
      "/TherapistDashboard/FinalizeBooking",
      RequestMethod.post,
      data: {"bookingId": bookingId, "bookingCode": code},
    );
    return response.data;
  }
}
