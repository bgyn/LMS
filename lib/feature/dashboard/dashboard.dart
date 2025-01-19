import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/config/route/route_path.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_event.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        children: [
          const Center(
            child: Text('Welcome to the dashboard'),
          ),
          ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthSignOut());
              },
              child: const Text('Logout')),
          ElevatedButton(
              onPressed: () {
                context.push(RoutePath.profile);
              },
              child: const Text('Profile'))
        ],
      ),
    );
  }
}
