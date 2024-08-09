import 'package:get_it/get_it.dart';
import 'package:soundmind_therapist/core/notifications/notification_service.dart';
import 'package:soundmind_therapist/core/notifications/push_notification.dart';
import 'package:soundmind_therapist/core/storage/hive/hive_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  sl.registerLazySingleton(() => LocalNotificationService());
  sl.registerLazySingleton(() => PushNotificationService());

  // Hive initialization
  final hiveService = HiveService();
  await hiveService.init();
  sl.registerLazySingleton(() => hiveService);

  // TODO: Add other services and dependencies here
}

