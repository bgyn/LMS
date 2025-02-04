import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lms/config/route/app_route.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/permisson/permission.dart';
import 'package:lms/core/services/notification_services.dart';
import 'package:lms/core/utils/shared_utility.dart';
import 'package:lms/core/utils/show_snackbar.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_event.dart';
import 'package:lms/feature/course/presentation/bloc/course_bloc.dart';
import 'package:lms/feature/my_course/presentation/bloc/my_course_bloc.dart';
import 'package:lms/feature/password_reset/presentation/bloc/password_reset_bloc.dart';
import 'package:lms/feature/payment/presentation/bloc/payment_bloc.dart';
import 'package:lms/feature/payment/presentation/cubit/stripe_cubit.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:lms/feature/splash/presentation/cubit/splash_cubit.dart';
import 'package:lms/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SharedUtility.enxureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationServices().initializeNotification();
  PermissionHandler.init();
  Stripe.publishableKey = dotenv.get("PUBLISHABLE_KEY");
  await initializeDependencies();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => sl<AuthBloc>()..add(AuthIsUserLoggedIn())),
          BlocProvider(create: (_) => ProfileBloc(sl(), sl())),
          BlocProvider(
            create: (_) => PasswordResetBloc(
              resetPassword: sl(),
              verifyOtp: sl(),
              sendPasswordReset: sl(),
            ),
          ),
          BlocProvider(create: (_) => CourseBloc(sl())),
          BlocProvider(create: (_) => PaymentBloc(sl())),
          BlocProvider(create: (_) => StripeCubit()),
          BlocProvider(create: (_) => sl<MyCourseBloc>()),
          BlocProvider(
              create: (_) => SplashCubit(
                    authbloc: sl(),
                    myCourseBloc: sl(),
                  ))
        ],
        child: MaterialApp.router(
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          title: 'LMS',
          theme: getAppTheme(context),
          routerDelegate: routeConfig.routerDelegate,
          routeInformationParser: routeConfig.routeInformationParser,
          routeInformationProvider: routeConfig.routeInformationProvider,
        ));
  }
}
