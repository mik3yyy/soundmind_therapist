import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/login/login.dart';
import 'package:soundmind_therapist/features/Onboarding/presentation/views/Onboarding_page.dart';
import 'package:soundmind_therapist/features/Onboarding/presentation/views/Splash_screen.dart';
import 'package:soundmind_therapist/features/Onboarding/presentation/views/introduction.dart';

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

  static const String introName = 'intro';
  static const String introPath = 'intro';

  static const String loginName = 'login';
  static const String loginPath = 'login';
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
        builder: (context, state, child) => Placeholder(),
        routes: [
          GoRoute(
            path: home,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) =>
                Placeholder(), // Replace with actual screen widget
          ),
          GoRoute(
            path: chat,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) =>
                Placeholder(), // Replace with actual screen widget
          ),
          GoRoute(
            path: settings,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) =>
                Placeholder(), // Replace with actual screen widget
            routes: [
              GoRoute(
                path: termsOfService,
                parentNavigatorKey: rootNavigatorKey,
                builder: (context, state) =>
                    Placeholder(), // Replace with actual screen widget
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
