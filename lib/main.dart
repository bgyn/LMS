import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lms/client/config/flavor_config.dart';
import 'package:lms/client/config/route/app_route.dart';
import 'package:lms/client/config/theme/theme.dart';
import 'package:lms/client/core/permisson/permission.dart';
import 'package:lms/client/core/services/notification_services.dart';
import 'package:lms/client/core/utils/shared_utility.dart';
import 'package:lms/client/core/utils/show_snackbar.dart';
import 'package:lms/client/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms/client/feature/auth/presentation/bloc/auth_event.dart';
import 'package:lms/client/feature/course/presentation/bloc/course_bloc.dart';
import 'package:lms/client/feature/my_course/presentation/bloc/my_course_bloc.dart';
import 'package:lms/client/feature/notifications/presentation/bloc/notification_bloc.dart';
import 'package:lms/client/feature/password_reset/presentation/bloc/password_reset_bloc.dart';
import 'package:lms/client/feature/payment/presentation/bloc/payment_bloc.dart';
import 'package:lms/client/feature/payment/presentation/cubit/stripe_cubit.dart';
import 'package:lms/client/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:lms/client/feature/splash/presentation/cubit/splash_cubit.dart';
import 'package:lms/client/injection_container.dart';
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
  FlavorConfig(flavor: Flavor.client, name: "LMS");
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
              create: (_) => NotificationBloc(
                  fetchNotification: sl(),
                  markAsRead: sl(),
                  markAllAsRead: sl())),
          BlocProvider(
              create: (_) => SplashCubit(
                    authbloc: sl(),
                    myCourseBloc: sl(),
                  ))
        ],
        child: MaterialApp.router(
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          title: FlavorConfig.instance.name,
          theme: getAppTheme(context),
          routerDelegate: routeConfig.routerDelegate,
          routeInformationParser: routeConfig.routeInformationParser,
          routeInformationProvider: routeConfig.routeInformationProvider,
        ));
  }
}
