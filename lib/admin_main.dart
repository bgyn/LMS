import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lms/admin/config/app_route.dart';
import 'package:lms/config/flavor_config.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/permisson/permission.dart';
import 'package:lms/core/utils/shared_utility.dart';
import 'package:lms/core/utils/show_snackbar.dart';
import 'package:lms/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SharedUtility.enxureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  PermissionHandler.init();
  await initializeDependencies();
  FlavorConfig(flavor: Flavor.admin, name: "Admin Panel");
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
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: FlavorConfig.instance.name,
      theme: getAppTheme(context),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
