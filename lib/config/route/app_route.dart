import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/config/route/route_path.dart';
import 'package:lms/core/utils/shared_utility.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_state.dart';
import 'package:lms/feature/auth/presentation/pages/sign_in_page.dart';
import 'package:lms/feature/auth/presentation/pages/sign_up_page.dart';
import 'package:lms/feature/dashboard/dashboard.dart';
import 'package:lms/feature/onboarding/presentation/onboarding_page.dart';
import 'package:lms/feature/profile/profile_page.dart';
import 'package:lms/feature/splash/presentation/splash_page.dart';
import 'package:lms/injection_container.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routeConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RoutePath.splash,
  refreshListenable: StreamToListenable([
    sl<AuthBloc>().stream,
  ]),
  redirect: (context, state) {
    final isOnboarded = SharedUtility.getIsOnboarding();
    final authState = context.read<AuthBloc>().state;

    final isLoggingIn = authState is AuthLoading;
    final isLoggedIn = authState is Authenticated;

    const loginLocation = RoutePath.signIn;
    const homeLocation = RoutePath.dashboard;
    const onboardingLocation = RoutePath.onboarding;
    const splashLocation = RoutePath.splash;
    const signUpLocation = RoutePath.signUp;

    final isGoingToLogin = state.matchedLocation == loginLocation;
    final isGoingToOnboarding = state.matchedLocation == onboardingLocation;
    final isGoingToInit = state.matchedLocation == splashLocation;
    final isGoingToSignUp = state.matchedLocation == signUpLocation;

    //If the user is logging in
    //and not going to the initial (splash) screen
    if (isLoggingIn && !isGoingToInit) {
      return splashLocation;
    }
    //If the user has not completed onboarding
    //and is not already on the onboarding page
    else if (!isLoggingIn && !isOnboarded && !isGoingToOnboarding) {
      return onboardingLocation;
    }
    //If the user is onboarded but not logged in,
    //and they are not going to the login page or sign-up page
    else if (!isLoggingIn &&
        isOnboarded &&
        !isLoggedIn &&
        !isGoingToLogin &&
        !isGoingToSignUp) {
      return loginLocation;
    }
    // If the user is logged in and trying to go to the login page,
    //or onboarded and trying to go to the onboarding page
    else if ((isLoggedIn && isGoingToLogin) ||
        (isOnboarded && isGoingToOnboarding) ||
        (isGoingToInit && !isLoggingIn)) {
      return homeLocation;
    }
    //default case
    else {
      return null;
    }
  },
  routes: <RouteBase>[
    GoRoute(
      path: RoutePath.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RoutePath.signUp,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: RoutePath.signIn,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: RoutePath.onboarding,
      builder: (context, state) => const OnBoardingpage(),
    ),
    GoRoute(
      path: RoutePath.dashboard,
      builder: (context, state) => const Dashboard(),
    ),
    GoRoute(
        path: RoutePath.profile,
        builder: (context, state) => const ProfilePage()),
  ],
);

class StreamToListenable extends ChangeNotifier {
  late final List<StreamSubscription> subscriptions;

  StreamToListenable(List<Stream> streams) {
    subscriptions = [];
    for (var e in streams) {
      var s = e.asBroadcastStream().listen(_tt);
      subscriptions.add(s);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    for (var e in subscriptions) {
      e.cancel();
    }
    super.dispose();
  }

  void _tt(event) => notifyListeners();
}
