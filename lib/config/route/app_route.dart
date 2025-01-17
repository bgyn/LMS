import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/utils/shared_utility.dart';
import 'package:lms/feature/auth/presentation/sign_in_page.dart';
import 'package:lms/feature/auth/presentation/sign_up_page.dart';
import 'package:lms/feature/onboarding/presentation/onboarding_page.dart';
import 'package:lms/feature/splash/presentation/splash_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routeConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/splash",
  redirect: (context, state) {
   
  },
  routes: <RouteBase>[
    GoRoute(
      path: "/splash",
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: "/signup",
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: "/signin",
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: "/onboarding",
      builder: (context, state) => const OnBoardingpage(),
    ),
  ],
);
