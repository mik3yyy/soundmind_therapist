import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:soundmind_therapist/core/routes/routes.dart';
import 'package:soundmind_therapist/core/services/injection_container.dart'
    as di;
import 'package:soundmind_therapist/core/services/injection_container.dart';
import 'package:soundmind_therapist/core/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_rejected_appointment.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/approve_appointment_request/approve_appointment_request_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_accepted_appointments/get_accepted_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_pending_appointments/get_pending_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_rejected_appointments/get_rejected_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_upcoming_appointment_request/get_upcoming_appointment_request_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/reject_appointment_request/reject_appointment_request_cubit.dart';
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
          create: (context) => sl<TopUpCubit>(),
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
