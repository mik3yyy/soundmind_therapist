import 'package:hive_flutter/hive_flutter.dart';
import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';

abstract class AppointmentHiveDataSource {
  Future<void> saveUpcomingAppointments(
      {required AppointmentModel appointment});
  Future<AppointmentModel?> getUpcomingAppointments();
  Future<void> deleteAppointments();
}

class AppointmentHiveDataSourceImpl extends AppointmentHiveDataSource {
  final Box _box;
  final String key = 'upcomingAppointments';

  AppointmentHiveDataSourceImpl({required Box box}) : _box = box;

  @override
  Future<void> saveUpcomingAppointments(
      {required AppointmentModel appointment}) async {
    await _box.put(key, appointment.toJson());
  }

  @override
  Future<AppointmentModel?> getUpcomingAppointments() async {
    var data = _box.get(key);
    if (data != null) {
      return AppointmentModel.fromJson(data);
    } else {
      return null;
    }
  }

  @override
  Future<void> deleteAppointments() async {
    await _box.delete(key);
  }
}
