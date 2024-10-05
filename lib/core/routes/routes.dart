import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/login/login.dart';
import 'package:soundmind_therapist/features/Onboarding/presentation/views/Onboarding_page.dart';
import 'package:soundmind_therapist/features/Onboarding/presentation/views/Splash_screen.dart';
import 'package:soundmind_therapist/features/Onboarding/presentation/views/introduction.dart';
import 'package:soundmind_therapist/features/appointment/presentation/views/appointment_page.dart';
import 'package:soundmind_therapist/features/main/presentation/views/main_page.dart';
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
  static const String referralsPath = 'referrals';
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
  // Navigator keys for nested navigation
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
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
              // builder: (context, state) =>
              //     HomeScreen(),
              routes: [
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
                      Placeholder(), // Replace with actual screen widget
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
            builder: (context, state) =>
                Placeholder(), // Replace with actual screen widget
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

          // GoRoute(
          //     path: walletPath,
          //     name: walletName,
          //     parentNavigatorKey: shellNavigatorKey,
          //     // builder: (context, state) =>
          //     //     WalletPage(), // Replace with actual screen widget
          //     pageBuilder: (context, state) {
          //       return CustomTransitionPage(
          //         key: state.pageKey,
          //         child: WalletPage(),
          //         transitionsBuilder:
          //             (context, animation, secondaryAnimation, child) {
          //           return FadeTransition(
          //             opacity: animation,
          //             child: child,
          //           );
          //         },
          //       );
          //     },
          //     routes: [
          //       GoRoute(
          //         path: addFundPath,
          //         name: addFundName,
          //         parentNavigatorKey: rootNavigatorKey,
          //         builder: (context, state) =>
          //             const AddFundsPage(), // Replace with actual screen widget
          //       ),
          //       GoRoute(
          //           path: withdrawPath,
          //           name: withdrawName,
          //           parentNavigatorKey: rootNavigatorKey,
          //           builder: (context, state) =>
          //               const WithdrawPage(), // Replace with actual screen widget
          //           routes: [
          //             GoRoute(
          //               path: add_amountPath,
          //               name: add_amountName,
          //               parentNavigatorKey: rootNavigatorKey,
          //               builder: (context, state) => AddAmountPage(
          //                 number: state.extra as String,
          //                 bank: state.uri.queryParameters,
          //               ), // Replace with actual screen widget
          //             ),
          //           ]),
          //     ]),
        ],
      ),
    ],
  );
}
