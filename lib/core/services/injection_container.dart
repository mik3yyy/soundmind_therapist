import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:soundmind_therapist/core/bloc_config/observer.dart';
import 'package:soundmind_therapist/core/network/network.dart';
import 'package:soundmind_therapist/core/network/url_config.dart';
import 'package:soundmind_therapist/core/notifications/notification_service.dart';
import 'package:soundmind_therapist/core/notifications/push_notification.dart';
import 'package:soundmind_therapist/core/storage/hive/hive_service.dart';
import 'package:soundmind_therapist/features/Authentication/data/datasources/Authentication_hive_data_source.dart';
import 'package:soundmind_therapist/features/Authentication/data/datasources/Authentication_remote_data_source.dart';
import 'package:soundmind_therapist/features/Authentication/data/repositories/Authentication_repository_impl.dart';
import 'package:soundmind_therapist/features/Authentication/domain/repositories/Authentication_repository.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/check_if_phone_and_email_exist.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/create_account.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/get_GAS.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/log_out.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/login.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/resend_otp.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/verify_email.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/check_user_data/check_if_phone_and_email_exist_cubit.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/cubit/resend_otp_cubit.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/cubit_gas/get_gas_cubit.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/therapist_profile/therapist_profile_cubit.dart';
import 'package:soundmind_therapist/features/appointment/data/datasources/appointment_hive_data_source.dart';
import 'package:soundmind_therapist/features/appointment/data/datasources/appointment_remote_data_source.dart';
import 'package:soundmind_therapist/features/appointment/data/repositories/appointment_repository_impl.dart';
import 'package:soundmind_therapist/features/appointment/domain/repositories/appointment_repository.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/approve_appointment_request.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/finalize_booking.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_accepted_request.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_appointment_data.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_appointment_request.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_pending_appointment.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_rejected_appointment.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_upcoming_appointment.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_user_metrics.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/reject_appointment_request.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/appointment_bloc.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/approve_appointment_request/approve_appointment_request_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/finalize_booking/finalize_booking_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_accepted_appointments/get_accepted_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_pending_appointments/get_pending_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_rejected_appointments/get_rejected_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_upcoming_appointment_request/get_upcoming_appointment_request_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_upcoming_appointments/get_upcoming_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_user_metrics/get_user_metrics_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/reject_appointment_request/reject_appointment_request_cubit.dart';
import 'package:soundmind_therapist/features/main/data/datasources/main_hive_data_source.dart';
import 'package:soundmind_therapist/features/main/data/datasources/main_remote_data_source.dart';
import 'package:soundmind_therapist/features/main/data/repositories/main_repository_impl.dart';
import 'package:soundmind_therapist/features/main/domain/repositories/main_repository.dart';
import 'package:soundmind_therapist/features/main/domain/usecases/get_main_data.dart';
import 'package:soundmind_therapist/features/main/presentation/blocs/main_bloc.dart';
import 'package:soundmind_therapist/features/patient/data/datasources/patient_hive_data_source.dart';
import 'package:soundmind_therapist/features/patient/data/datasources/patient_remote_data_source.dart';
import 'package:soundmind_therapist/features/patient/data/repositories/patient_repository_impl.dart';
import 'package:soundmind_therapist/features/patient/domain/repositories/patient_repository.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/add_user_note.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/create_referal.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/get_chat_room.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/get_patient_data.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/get_referral.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/get_referral_intituition.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/get_user_chats.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/request_patients_note.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/add_user_note/add_user_note_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/create_referral/create_referral_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_patient_details/get_patient_details_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_referral_instituitions/get_referral_institutions_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_referrals/get_referrals_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_user_chat_room/get_user_chat_rooms_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_user_chat_room_messages/get_user_chat_room_messages_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/patient_bloc.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/request_for_patient_notes/request_for_patient_notes_cubit.dart';
import 'package:soundmind_therapist/features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:soundmind_therapist/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:soundmind_therapist/features/wallet/domain/usecases/confirm_wallet_top_up.dart';
import 'package:soundmind_therapist/features/wallet/domain/usecases/get_banks.dart';
import 'package:soundmind_therapist/features/wallet/domain/usecases/get_user_transaction.dart';
import 'package:soundmind_therapist/features/wallet/domain/usecases/get_user_wallet.dart';
import 'package:soundmind_therapist/features/wallet/domain/usecases/initiate_wallet_top_up.dart';
import 'package:soundmind_therapist/features/wallet/domain/usecases/resolve_bank.dart';
import 'package:soundmind_therapist/features/wallet/domain/usecases/withdraw_to_bank.dart';
import 'package:soundmind_therapist/features/wallet/presentation/blocs/get_bank/get_banks_cubit.dart';
import 'package:soundmind_therapist/features/wallet/presentation/blocs/get_bank_transactions/get_bank_transactions_cubit.dart';
import 'package:soundmind_therapist/features/wallet/presentation/blocs/resolve_bank_account/resolve_bank_account_cubit.dart';
import 'package:soundmind_therapist/features/wallet/presentation/blocs/top_up/topup_wallet_cubit.dart';
import 'package:soundmind_therapist/features/wallet/presentation/blocs/wallet_bloc.dart';
import 'package:soundmind_therapist/features/wallet/presentation/blocs/withdraw_to_bank/withdraw_to_bank_cubit.dart';
import '../../features/Authentication/domain/usecases/check_user.dart';
import '../../features/wallet/domain/repositories/wallet_repository.dart';

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
    ..registerFactory(() => CheckIfPhoneAndEmailExistCubit(checkIfPhoneAndEmailExist: sl()))
    ..registerLazySingleton(() => CheckIfPhoneAndEmailExist(repository: sl()));
  sl
    ..registerFactory(() => GetGasCubit(sl()))
    ..registerLazySingleton(() => GetGasUsecase(repository: sl()));
  sl
    ..registerFactory(() => ResendOtpCubit(resendVerificationOtp: sl()))
    ..registerLazySingleton(() => ResendVerificationOtp(repository: sl()));
  sl
    ..registerFactory(() => AuthenticationBloc(
        login: sl(),
        createAccount: sl(),
        checkUser: sl(),
        logOutUsecase: sl(),
        verifyEmail: sl(),
        resendVerificationOtp: sl()))
    ..registerLazySingleton(() => CreateAccountUseCase(repository: sl()))
    ..registerLazySingleton(() => LogOutUsecase(repository: sl()))
    ..registerLazySingleton(() => VerifyEmail(repository: sl()))
    ..registerLazySingleton(() => CheckUserUseCase(repository: sl()))
    ..registerLazySingleton(() => Login(repository: sl()));
  sl
    ..registerFactory(() => TherapistProfileCubit(repository: sl()))
    // AuthenticationHiveDataSource
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(authenticationRemoteDataSource: sl(), authenticationHiveDataSource: sl()))
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(network: sl()),
    )
    ..registerLazySingleton<AuthenticationHiveDataSource>(() => AuthenticationHiveDataSourceImpl(box: sl()))
    ..registerLazySingleton(() => Network(baseUrl: UrlConfig.baseUrl, showLog: true));

  sl
    ..registerFactory(() => MainBloc(getMainData: sl()))
    ..registerLazySingleton(() => GetMainData(repository: sl()))

    // AuthenticationHiveDataSource
    ..registerLazySingleton<MainRepository>(() => MainRepositoryImpl(remoteDataSource: sl(), hiveDataSource: sl()))
    ..registerLazySingleton<MainRemoteDataSource>(
      () => MainRemoteDataSourceImpl(network: sl()),
    )
    ..registerLazySingleton<MainHiveDataSource>(
      () => MainHiveDataSourceImpl(),
    );

  sl
    ..registerFactory(() => GetUserMetricsCubit(getUserMetricsUseCase: sl())) //GetUserMetricsCubit
    ..registerLazySingleton(() => GetUserMetrics(repository: sl()));

  sl
    ..registerFactory(() => FinalizeBookingCubit(finalizeBookingUsecase: sl())) //GetUserMetricsCubit
    ..registerLazySingleton(() => FinalizeBookingUsecase(repository: sl()));
  sl
    ..registerFactory(() => AppointmentBloc(getAppointmentData: sl())) //GetUserMetricsCubit
    ..registerLazySingleton(() => GetAppointmentData(repository: sl()))

    // AuthenticationHiveDataSource
    ..registerLazySingleton<AppointmentRepository>(
        () => AppointmentRepositoryImpl(remoteDataSource: sl(), hiveDataSource: sl()))
    ..registerLazySingleton<AppointmentRemoteDataSource>(
      () => AppointmentRemoteDataSourceImpl(network: sl()),
    )
    ..registerLazySingleton<AppointmentHiveDataSource>(
      () => AppointmentHiveDataSourceImpl(box: box),
    );

  sl
    ..registerFactory(() => GetAcceptedAppointmentsCubit(getAcceptedAppointmentsUseCase: sl()))
    ..registerLazySingleton(() => GetAcceptedAppointments(repository: sl()));

  sl
    ..registerFactory(() => GetPendingAppointmentsCubit(getPendingAppointmentsUseCase: sl()))
    ..registerLazySingleton(() => GetPendingAppointments(repository: sl()));

  sl
    ..registerFactory(() => ApproveAppointmentCubit(approveAppointmentRequestUseCase: sl()))
    ..registerLazySingleton(() => ApproveAppointmentRequest(repository: sl()));

  sl
    ..registerFactory(() => GetRejectedAppointmentsCubit(getRejectedAppointmentsUseCase: sl()))
    ..registerLazySingleton(() => GetRejectedAppointments(repository: sl()));

  sl
    ..registerFactory(() => RejectAppointmentCubit(rejectAppointmentRequestUseCase: sl()))
    ..registerLazySingleton(() => RejectAppointmentRequest(repository: sl()));

  sl
    ..registerFactory(() => GetUpcomingAppointmentRequestCubit(getUpcomingAppointmentRequestUseCase: sl()))
    ..registerLazySingleton(() => GetUpcomingAppointmentRequest(repository: sl())); //GetUpcomingAppointmentsCubit
  sl
    ..registerFactory(() => GetUpcomingAppointmentsCubit(getUpcomingAppointmentsUseCase: sl()))
    ..registerLazySingleton(() => GetUpcomingAppointments(repository: sl()));
  sl
    ..registerFactory(() => TopUpCubit(initiateWalletTopUp: sl(), confirmWalletTopUp: sl()))
    ..registerLazySingleton(() => InitiateWalletTopUp(repository: sl()))
    ..registerLazySingleton(() => ConfirmWalletTopUp(repository: sl()));

  sl
    ..registerFactory(() => GetBankTransactionsCubit(getUserWalletTransactions: sl()))
    ..registerLazySingleton(() => GetUserWalletTransactions(repository: sl()));
  sl
    ..registerFactory(() => GetBanksCubit(getBanks: sl()))
    ..registerLazySingleton(() => GetBanks(repository: sl()));

  sl
    ..registerFactory(() => WithdrawToBankCubit(withdrawToBank: sl()))
    ..registerLazySingleton(() => WithdrawToBank(repository: sl()));

  sl
    ..registerFactory(() => ResolveBankAccountCubit(resolveBankAccount: sl()))
    ..registerLazySingleton(() => ResolveBankAccount(repository: sl()));

  sl
    ..registerFactory(() => WalletBloc(getUserWallet: sl()))
    ..registerLazySingleton(() => GetUserWallet(repository: sl()))
    ..registerLazySingleton<WalletRepository>(
      () => WalletRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton<WalletRemoteDataSource>(
      () => WalletRemoteDataSourceImpl(network: sl()),
    );

  sl
    ..registerFactory(() => PatientBloc(getPatientData: sl()))
    ..registerLazySingleton(() => GetPatientData(repository: sl()))

    // AuthenticationHiveDataSource
    ..registerLazySingleton<PatientRepository>(
        () => PatientRepositoryImpl(remoteDataSource: sl(), hiveDataSource: sl()))
    ..registerLazySingleton<PatientRemoteDataSource>(
      () => PatientRemoteDataSourceImpl(network: sl()),
    )
    ..registerLazySingleton<PatientHiveDataSource>(
      () => PatientHiveDataSourceImpl(),
    );

// Registering Use Cases and Cubits for the Patient Feature
  sl
    // AddUserNote
    ..registerFactory(() => AddUserNoteCubit(addUserNoteUseCase: sl()))
    ..registerLazySingleton(() => AddUserNote(repository: sl()))

    // GetPatientDetails
    ..registerFactory(() => GetPatientDetailsCubit(getPatientDetailsUseCase: sl()))
    ..registerLazySingleton(() => GetPatientDetails(repository: sl()))

    // RequestForPatientNotes
    ..registerFactory(() => RequestForPatientNotesCubit(requestForPatientNotesUseCase: sl()))
    ..registerLazySingleton(() => RequestForPatientNotes(repository: sl()))

    // GetUserChatRooms
    ..registerFactory(() => GetUserChatRoomsCubit(getUserChatRoomsUseCase: sl()))
    ..registerLazySingleton(() => GetUserChatRooms(repository: sl()))

    // GetUserChatRoomMessages
    ..registerFactory(() => GetUserChatRoomMessagesCubit(getUserChatRoomMessagesUseCase: sl()))
    ..registerLazySingleton(() => GetUserChatRoomMessages(repository: sl()))

    // GetReferralInstitutions
    ..registerFactory(() => GetReferralInstitutionsCubit(getReferralInstitutionsUseCase: sl()))
    ..registerLazySingleton(() => GetReferralInstitutions(repository: sl()))

    // GetReferrals
    ..registerFactory(() => GetReferralsCubit(getReferralsUseCase: sl()))
    ..registerLazySingleton(() => GetReferrals(repository: sl()))

    // CreateReferral
    ..registerFactory(() => CreateReferralCubit(createReferralUseCase: sl()))
    ..registerLazySingleton(() => CreateReferral(repository: sl()));

  Bloc.observer = SimpleBlocObserver();
}
