import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:soundmind_therapist/core/network/network.dart';
import 'package:soundmind_therapist/core/network/url_config.dart';
import 'package:soundmind_therapist/core/notifications/notification_service.dart';
import 'package:soundmind_therapist/core/notifications/push_notification.dart';
import 'package:soundmind_therapist/core/storage/hive/hive_service.dart';
import 'package:soundmind_therapist/features/Authentication/data/datasources/Authentication_hive_data_source.dart';
import 'package:soundmind_therapist/features/Authentication/data/datasources/Authentication_remote_data_source.dart';
import 'package:soundmind_therapist/features/Authentication/data/repositories/Authentication_repository_impl.dart';
import 'package:soundmind_therapist/features/Authentication/domain/repositories/Authentication_repository.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/create_account.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/login.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  sl.registerLazySingleton(() => LocalNotificationService());
  sl.registerLazySingleton(() => PushNotificationService());

  // Hive initialization
  final hiveService = HiveService();
  await hiveService.init();
  await Hive.openBox("userBox");
  sl.registerLazySingleton(() => hiveService);
  final box = Hive.box('userBox');
  sl.registerSingleton<Box>(box);

  sl
    ..registerFactory(
        () => AuthenticationBloc(login: sl(), createAccount: sl()))
    ..registerLazySingleton(() => CreateAccount(repository: sl()))
    ..registerLazySingleton(() => Login(repository: sl()))

    // AuthenticationHiveDataSource
    ..registerLazySingleton<AuthenticationRepository>(() =>
        AuthenticationRepositoryImpl(
            authenticationRemoteDataSource: sl(),
            authenticationHiveDataSource: sl()))
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(network: sl()),
    )
    ..registerLazySingleton<AuthenticationHiveDataSource>(
        () => AuthenticationHiveDataSourceImpl(box: sl()))
    ..registerLazySingleton(
        () => Network(baseUrl: UrlConfig.baseUrl, showLog: true));
}
