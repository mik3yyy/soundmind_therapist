import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/create_account/create_account.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/create_account/personal_info.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/create_account/practice_info.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/create_account/professional_info.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/create_account/profile_info.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/create_account/signup_succesful.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/create_account/verification_info.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/login/login.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/verify_email.dart';
import 'package:soundmind_therapist/features/Onboarding/presentation/views/Onboarding_page.dart';
import 'package:soundmind_therapist/features/Onboarding/presentation/views/Splash_screen.dart';
import 'package:soundmind_therapist/features/Onboarding/presentation/views/introduction.dart';
import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';
import 'package:soundmind_therapist/features/appointment/presentation/views/appointment_page.dart';
import 'package:soundmind_therapist/features/main/presentation/views/home_screen/home_screen.dart';
import 'package:soundmind_therapist/features/main/presentation/views/home_screen/view_session.dart';
import 'package:soundmind_therapist/features/main/presentation/views/main_page.dart';
import 'package:soundmind_therapist/features/main/presentation/views/setting/settings_screen.dart';
import 'package:soundmind_therapist/features/patient/data/models/chat_room.dart';
import 'package:soundmind_therapist/features/patient/presentation/views/chat/chat_room.dart';
import 'package:soundmind_therapist/features/patient/presentation/views/patient_page.dart';
import 'package:soundmind_therapist/features/patient/presentation/views/referaals/referrals.dart';
import 'package:soundmind_therapist/features/patient/presentation/views/view_patient.dart';
import 'package:soundmind_therapist/features/wallet/presentation/views/wallet_page.dart';
import 'package:soundmind_therapist/features/wallet/presentation/views/withdraw_amount.dart';
import 'package:soundmind_therapist/features/wallet/presentation/views/withdraw_page.dart';

import '../../features/wallet/presentation/views/add_funds.dart';

// Define route constants
class Routes {
  static const String home = '/';
  static const String chat = '/chat';
  static const String settings = '/settings';
  static const String termsOfService = 'terms-of-services';
  static const String splashName = 'splash';
  static const String splashPath = '/';
  static const String pinhName = 'pin';
  static const String pinhPath = '/pin';
  static const String onboardingName = 'onboarding';
  static const String onboardingPath = 'onboarding';
  static const String referralsName = 'referrals';
  static const String referralsPath = '/referrals';
  static const String walletName = 'wallet';
  static const String walletPath = '/wallet';
  static const String introName = 'intro';
  static const String introPath = 'intro';

  static const String loginName = 'login';
  static const String loginPath = 'login';

  static const String withdrawPath = 'withdraw';
  static const String withdrawName = 'withdraw';
  static const String homeName = 'home';
  static const String homePath = '/home';
  static const String settingsPath = 'settings';

  static const String settingsName = 'settings';
  static const String chatPath = '/chat';
  static const String chatNAme = 'chat';

  static const String appointmentName = 'appointment';
  static const String appointmentPath = '/appointment';
  static const String notificationName = 'notification';
  static const String notificationPath = 'notification';

  static const String personal_detailsName = 'personal_details';
  static const String personal_detailsPath = 'personal_details';

  static const String change_passwordName = 'change_password';
  static const String change_passwordPath = 'change_password';

  static const String add_amountName = 'add_amount';
  static const String add_amountPath = 'add_amount';

  static const String addFundPath = 'addFund';
  static const String addFundName = 'addFund';

  static const String chatRoomPath = 'chatRoom/:id';
  static const String chatRoomName = 'chatRoom';

  static const String patientPath = '/patient';
  static const String patientName = 'patient';
  static const String view_sessionPath = 'view_session';
  static const String view_sessionName = 'view_session';

  static const String view_patientPath = 'view_patient/:id';
  static const String view_patientName = 'view_patient';

  static const String personal_infoPath = '/personal_info';
  static const String personal_infoName = 'personal_info';
  static const String professioanlInfoPath = '/professioanlInfo';
  static const String professioanlInfoName = 'professioanlInfo';
  static const String practiceInfoPath = '/practiceInfo';
  static const String practiceInfoName = 'practiceInfo';
  static const String verificationInfoPath = '/verificationInfo';
  static const String verificationInfoName = 'verificationInfo';
  static const String profileInfoPath = '/profileInfo';
  static const String profileInfoName = 'profileInfo';
  static const String sucessSignupPath = '/sucessSignup';
  static const String sucessSignupName = 'sucessSignup';
  static const String verifyPath = '/verify';
  static const String verifyName = 'verify';
  // Navigator keys for nested navigation
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey2 =
      GlobalKey<NavigatorState>();
// ChattRoomScreen(
//                                     chat_id: chatRoom.chatRoomID,
//                                     user_id: chatRoom.receiverID),
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      //Governance, Initial  Question
      //Genereric
      GoRoute(
        path: splashPath,
        name: splashName,
        builder: (context, state) =>
            const SplashScreen(), // Replace with actual screen widget
        routes: [
          GoRoute(
            path: onboardingPath,
            name: onboardingName,
            builder: (context, state) =>
                const OnboardingScreen(), // Replace with actual screen widget
            routes: [
              GoRoute(
                path: introPath,
                name: introName,
                builder: (context, state) => const IntroductionScreen(),
                routes: [],
              ),
            ],
          ),
          GoRoute(
            path: loginPath,
            name: loginName,
            builder: (context, state) => const Loginscreen(),
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey2,
        builder: (context, state, child) => CreateAccountScreen(
          child: child,
        ),
        routes: [
          GoRoute(
            path: personal_infoPath,
            name: personal_infoName,
            builder: (context, state) => const PersonalInfoScreen(),
            routes: [],
          ),
          GoRoute(
            path: professioanlInfoPath,
            name: professioanlInfoName,
            builder: (context, state) => const ProfessionalInfoScreen(),
            routes: [],
          ),
          GoRoute(
            path: practiceInfoPath,
            name: practiceInfoName,
            builder: (context, state) => const PracticeInfoScreen(),
            routes: [],
          ),
          GoRoute(
            path: verificationInfoPath,
            name: verificationInfoName,
            builder: (context, state) => const VerificationInfoScreen(),
            routes: [],
          ),
          GoRoute(
            path: profileInfoPath,
            name: profileInfoName,
            builder: (context, state) => const ProfileInfoScreen(),
            routes: [],
          ),
        ],
      ),
      GoRoute(
        path: verifyPath,
        name: verifyName,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => VerifyEmail(
          email: state.extra as String,
        ),
        routes: [],
      ),
      GoRoute(
        path: sucessSignupPath,
        name: sucessSignupName,
        builder: (context, state) => const SignupSuccesfulScreen(),
        routes: [],
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => MainPage(
          child: child,
          routeState: state,
        ),
        routes: [
          GoRoute(
              path: homePath,
              name: homeName,
              parentNavigatorKey: shellNavigatorKey,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: HomeScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                );
              },
              // builder: (context, state) =>
              //     HomeScreen(),
              routes: [
                GoRoute(
                  path: view_sessionPath,
                  name: view_sessionName,
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) => ViewSessionScreen(
                    appointment: state.extra as AppointmentModel,
                  ), // Replace with actual screen widget
                ),
                GoRoute(
                  path: notificationPath,
                  name: notificationName,
                  parentNavigatorKey: shellNavigatorKey,

                  builder: (context, state) =>
                      Placeholder(), // Replace with actual screen widget
                ),
                GoRoute(
                  path: settingsPath,
                  name: settingsName,
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) =>
                      SettingPage(), // Replace with actual screen widget
                  routes: [
                    GoRoute(
                      path: termsOfService,
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (context, state) =>
                          Placeholder(), // Replace with actual screen widget
                    ),
                    GoRoute(
                      path: personal_detailsPath,
                      name: personal_detailsName,
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (context, state) => const Placeholder(),
                    ),
                    GoRoute(
                      path: change_passwordPath,
                      name: change_passwordName,
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (context, state) => Placeholder(),
                    ),
                  ],
                ),
              ]),
          GoRoute(
            path: chatPath,
            name: chatNAme,
            parentNavigatorKey: shellNavigatorKey,
            // builder: (context, state) => const ChatPage(),
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: Placeholder(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            },
          ),
          GoRoute(
            path: appointmentPath,
            name: appointmentName,
            parentNavigatorKey: shellNavigatorKey,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: AppointmentPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            },
            // builder: (context, state) => AppointmentPage(),
            routes: [],
          ),
          GoRoute(
            path: referralsPath,
            name: referralsName,
            parentNavigatorKey: shellNavigatorKey,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: ReferallPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            },
          ),
          GoRoute(
            path: patientPath,
            name: patientName,
            parentNavigatorKey: shellNavigatorKey,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: PatientPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            },
            routes: [
              // GoRoute(path: path)

              GoRoute(
                path: view_patientPath,
                name: view_patientName,
                parentNavigatorKey: rootNavigatorKey,
                builder: (context, state) => ViewPatient(
                  chatRoom: state.extra as ChatRoom,
                  id: state.pathParameters['id']!,
                ), // Replace with actual screen widget
              ),
              GoRoute(
                path: chatRoomPath,
                name: chatRoomName,
                parentNavigatorKey: rootNavigatorKey,
                builder: (context, state) => ChattRoomScreen(
                  chat_id: int.parse(state.pathParameters['id']!),
                  user_id: state.extra as ChatRoom,
                ),
              ),
            ],
          ),
          GoRoute(
              path: walletPath,
              name: walletName,
              parentNavigatorKey: shellNavigatorKey,
              // builder: (context, state) =>
              //     WalletPage(), // Replace with actual screen widget
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: WalletPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                );
              },
              routes: [
                GoRoute(
                  path: addFundPath,
                  name: addFundName,
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) =>
                      const AddFundsPage(), // Replace with actual screen widget
                ),
                GoRoute(
                    path: withdrawPath,
                    name: withdrawName,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) =>
                        const WithdrawPage(), // Replace with actual screen widget
                    routes: [
                      GoRoute(
                        path: add_amountPath,
                        name: add_amountName,
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (context, state) => AddAmountPage(
                          number: state.extra as String,
                          bank: state.uri.queryParameters,
                        ), // Replace with actual screen widget
                      ),
                    ]),
              ]),
        ],
      ),
    ],
  );
}
