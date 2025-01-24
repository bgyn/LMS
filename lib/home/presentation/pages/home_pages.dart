import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_state.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileLoaded) {
            return Text("Welcome, ${state.profile?.name ?? ""}");
          }
          return const Text('Welcome');
        }),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
