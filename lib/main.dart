import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lms/config/route/app_route.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/utils/shared_utility.dart';
import 'package:lms/core/utils/show_snackbar.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_event.dart';
import 'package:lms/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SharedUtility.enxureInitialized();
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
          BlocProvider(create: (_) => sl<AuthBloc>()..add(AuthCheckRequested()))
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
