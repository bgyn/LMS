import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/config/route/route_path.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/feature/course/presentation/bloc/course_bloc.dart';
import 'package:lms/feature/course/presentation/bloc/course_event.dart';
import 'package:lms/feature/course/presentation/widgets/course_grid.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_event.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_state.dart';
import 'package:lms/feature/home/presentation/widgets/custom_search_bar.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(ProfileGet());
    context.read<CourseBloc>().add(FetchCourses());
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
              splashColor: Colors.transparent,
              onPressed: () {
                context.push(RoutePath.settings);
              },
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.settings,
                color: Colors.grey,
              )),
          IconButton(
              splashColor: Colors.transparent,
              onPressed: () {
                context.push(RoutePath.notification);
              },
              icon: const Icon(
                Icons.notifications,
                color: Colors.grey,
              )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.03.w(context)),
        child: Column(
          children: [
            const CustomSearchBar(),
            SizedBox(
              height: 0.03.h(context),
            ),
            const Expanded(child: CourseGrid()),
          ],
        ),
      ),
    );
  }
}
