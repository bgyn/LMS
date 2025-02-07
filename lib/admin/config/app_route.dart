import 'package:go_router/go_router.dart';
import 'package:lms/admin/feature/dashboard/presentation/dashboard_page.dart';

final GoRouter router = GoRouter(
  initialLocation: "/",
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (context, state) => const DashboardPage(),
    )
  ],
);
