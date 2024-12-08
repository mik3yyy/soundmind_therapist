import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:soundmind_therapist/core/routes/routes.dart';
import 'package:soundmind_therapist/core/services/injection_container.dart'
    as di;
import 'package:soundmind_therapist/core/services/injection_container.dart';
import 'package:soundmind_therapist/core/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/check_if_phone_and_email_exist.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/check_user_data/check_if_phone_and_email_exist_cubit.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/cubit/resend_otp_cubit.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/cubit_gas/get_gas_cubit.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_rejected_appointment.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_user_metrics.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/approve_appointment_request/approve_appointment_request_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_accepted_appointments/get_accepted_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_pending_appointments/get_pending_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_rejected_appointments/get_rejected_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_upcoming_appointment_request/get_upcoming_appointment_request_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_upcoming_appointments/get_upcoming_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_user_metrics/get_user_metrics_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/reject_appointment_request/reject_appointment_request_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/add_user_note/add_user_note_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/create_referral/create_referral_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_patient_details/get_patient_details_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_referral_instituitions/get_referral_institutions_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_referrals/get_referrals_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_user_chat_room/get_user_chat_rooms_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_user_chat_room_messages/get_user_chat_room_messages_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/patient_bloc.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/request_for_patient_notes/request_for_patient_notes_cubit.dart';
import 'package:soundmind_therapist/features/wallet/presentation/blocs/get_bank/get_banks_cubit.dart';
import 'package:soundmind_therapist/features/wallet/presentation/blocs/get_bank_transactions/get_bank_transactions_cubit.dart';
import 'package:soundmind_therapist/features/wallet/presentation/blocs/resolve_bank_account/resolve_bank_account_cubit.dart';
import 'package:soundmind_therapist/features/wallet/presentation/blocs/top_up/topup_wallet_cubit.dart';
import 'package:soundmind_therapist/features/wallet/presentation/blocs/wallet_bloc.dart';
import 'package:soundmind_therapist/features/wallet/presentation/blocs/withdraw_to_bank/withdraw_to_bank_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(
  //     fileName:
  //         '.env'); // Load environment variables from application folder
  await di.init(); // Initialize dependency injection
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthenticationBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<GetUpcomingAppointmentRequestCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<GetAcceptedAppointmentsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<ApproveAppointmentCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<RejectAppointmentCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<GetAcceptedAppointmentsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<GetRejectedAppointmentsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<
              GetUpcomingAppointmentRequestCubit>(), //GetPendingAppointmentsCubit
        ),
        BlocProvider(
          create: (context) =>
              sl<GetPendingAppointmentsCubit>(), //GetPendingAppointmentsCubit
        ),
        BlocProvider(
          create: (context) => sl<ResolveBankAccountCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<TopUpCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<WalletBloc>(), //UpcomingAppointmentCubit
        ),
        BlocProvider(
          create: (context) =>
              sl<WithdrawToBankCubit>(), //UpcomingAppointmentCubit
        ),
        BlocProvider(
          create: (context) => sl<GetBanksCubit>(), //UpcomingAppointmentCubit
        ),
        BlocProvider(
          create: (context) => sl<GetBankTransactionsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<GetUpcomingAppointmentsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<TopUpCubit>(),
        ), //GetUpcomingAppointmentsCubit
        BlocProvider(
          create: (context) => sl<GetUserMetricsCubit>(), //PatientBloc
        ),
        BlocProvider(
          create: (context) => sl<PatientBloc>(), //PatientBloc
        ),
        BlocProvider(
          create: (context) => sl<AddUserNoteCubit>(),
        ),

        // GetPatientDetailsCubit
        BlocProvider(
          create: (context) => sl<GetPatientDetailsCubit>(),
        ),

        // RequestForPatientNotesCubit
        BlocProvider(
          create: (context) => sl<RequestForPatientNotesCubit>(),
        ),

        // GetUserChatRoomsCubit
        BlocProvider(
          create: (context) => sl<GetUserChatRoomsCubit>(),
        ),

        // GetUserChatRoomMessagesCubit
        BlocProvider(
          create: (context) => sl<GetUserChatRoomMessagesCubit>(),
        ),

        // GetReferralInstitutionsCubit
        BlocProvider(
          create: (context) => sl<GetReferralInstitutionsCubit>(),
        ), //ResendOtpCubit
        BlocProvider(
          create: (context) => sl<ResendOtpCubit>(),
        ), //ResendOtpCubit
        // GetReferralsCubit
        BlocProvider(
          create: (context) => sl<GetReferralsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<GetGasCubit>(),
        ),
        // CreateReferralCubit
        BlocProvider(
          create: (context) => sl<CreateReferralCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<CheckIfPhoneAndEmailExistCubit>(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          // Use builder only if you need to use library outside ScreenUtilInit context
          builder: (_, child) {
            return MaterialApp.router(
              title: 'soundmind_therapist app',
              theme: appTheme,
              darkTheme: darkTheme,
              routerConfig: Routes.router,
              debugShowCheckedModeBanner: false,
            );
          }),
    );
  }
}
