import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/config/route/route_path.dart';
import 'package:lms/core/utils/shared_utility.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_state.dart';
import 'package:lms/feature/course/domain/model/course_model.dart';
import 'package:lms/feature/course_detail/presentation/pages/course_details.dart';
import 'package:lms/feature/password_reset/presentation/pages/forgot_password_page.dart';
import 'package:lms/feature/password_reset/presentation/pages/password_reset_page.dart';
import 'package:lms/feature/auth/presentation/pages/sign_in_page.dart';
import 'package:lms/feature/auth/presentation/pages/sign_up_page.dart';
import 'package:lms/feature/password_reset/presentation/pages/verify_otp_page.dart';
import 'package:lms/feature/dashboard/dashboard.dart';
import 'package:lms/feature/inbox/presentation/pages/inbox_page.dart';
import 'package:lms/feature/my_course/presentation/pages/my_course_page.dart';
import 'package:lms/feature/onboarding/presentation/onboarding_page.dart';
import 'package:lms/feature/payment/presentation/pages/payment_intent.dart';
import 'package:lms/feature/profile/domain/model/profile_model.dart';
import 'package:lms/feature/profile/presentation/pages/edit_profile_page.dart';
import 'package:lms/feature/profile/presentation/pages/profile_page.dart';
import 'package:lms/feature/splash/presentation/splash_page.dart';
import 'package:lms/feature/home/presentation/pages/home_pages.dart';
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
    const homeLocation = RoutePath.home;
    const onboardingLocation = RoutePath.onboarding;
    const splashLocation = RoutePath.splash;
    const signUpLocation = RoutePath.signUp;
    const forgotPasswordLocation = RoutePath.forgotPassword;
    const verifyOtpLocation = RoutePath.verifyOtp;
    const passwordResetLocation = RoutePath.resetPassword;

    final isGoingToForgotPassword =
        state.matchedLocation == forgotPasswordLocation;
    final isGoingToPasswordReset =
        state.matchedLocation == passwordResetLocation;
    final isGoingToVerifyOtp = state.matchedLocation == verifyOtpLocation;
    final isGoingToLogin = state.matchedLocation == loginLocation;
    final isGoingToOnboarding = state.matchedLocation == onboardingLocation;
    final isGoingToInit = state.matchedLocation == splashLocation;
    final isGoingToSignUp = state.matchedLocation == signUpLocation;

    //if the user is going to the forgot password page
    if (isGoingToForgotPassword ||
        isGoingToPasswordReset ||
        isGoingToVerifyOtp) {
      return null;
    }

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
        (isLoggedIn && isGoingToSignUp) ||
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
      path: RoutePath.forgotPassword,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: RoutePath.onboarding,
      builder: (context, state) => const OnBoardingpage(),
    ),
    GoRoute(
        path: RoutePath.verifyOtp,
        builder: (context, state) {
          final email = state.extra as String;
          return VerifyOtpPage(
            email: email,
          );
        }),
    GoRoute(
      path: RoutePath.resetPassword,
      builder: (context, state) {
        final email = state.extra as String;
        return PasswordResetPage(email: email);
      },
    ),
    GoRoute(
      path: RoutePath.courseDetail,
      builder: (context, state) {
        final id = state.extra as String;
        return CourseDetails(
          id: id,
        );
      },
    ),
    GoRoute(
        path: RoutePath.paymentIntent,
        builder: (context, state) {
          final res = state.extra as String;
          final resDecoded = jsonDecode(res);
          final amount = resDecoded['amount'];
          final courseId = resDecoded['courseId'];
          final course = CourseModel.fromJson(jsonDecode(resDecoded['course']));
          return PaymentIntentPage(
            course: course,
            amount: amount,
            courseId: courseId,
          );
        }),

    //shell route
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => Dashboard(
              body: child,
            ),
        routes: [
          GoRoute(
            path: RoutePath.home,
            builder: (context, state) => const HomePages(),
          ),
          GoRoute(
            path: RoutePath.myCourse,
            builder: (context, state) => const MyCoursePage(),
          ),
          GoRoute(
            path: RoutePath.inbox,
            builder: (context, state) => const InboxPage(),
          ),
          GoRoute(
            path: RoutePath.profile,
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
              path: RoutePath.editProfile,
              builder: (context, state) {
                final res = state.extra as String;
                final profile = ProfileModel.fromMap(jsonDecode(res));
                return EditProfilePage(
                  profile: profile,
                );
              }),
        ])
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
