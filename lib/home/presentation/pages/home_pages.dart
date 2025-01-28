import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_event.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_event.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_state.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(ProfileGet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              return RichText(
                text: TextSpan(
                  text: "Welcome", // The static part
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize:
                          0.015.toRes(context)), // Style for the "Welcome" part
                  children: [
                    TextSpan(
                      text:
                          state.profile?.name?.split(" ")[0].isNotEmpty == true
                              ? ', ${state.profile?.name?.split(" ")[0]}'
                              : '',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 0.015.toRes(context),
                        color: ColorPalette.primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Text("Welcome");
          },
        ),
        actions: [
          IconButton(
              onPressed: () {},
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.settings,
                color: Colors.grey,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.grey,
              )),
        ],
      ),
      body: Column(
        children: [
          const Center(
            child: Text('Home Page'),
          ),
          ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthSignOut());
              },
              child: const Text('Logout'))
        ],
      ),
    );
  }
}
