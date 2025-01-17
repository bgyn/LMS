import 'package:flutter/material.dart';
import 'package:lms/config/route/app_route.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/utils/shared_utility.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedUtility.enxureInitialized();
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'LMS',
      theme: getAppTheme(context),
      routerDelegate: routeConfig.routerDelegate,
      routeInformationParser: routeConfig.routeInformationParser,
      routeInformationProvider: routeConfig.routeInformationProvider,
    );
  }
}
