import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/feature/my_course/presentation/bloc/my_course_bloc.dart';
import 'package:lms/feature/my_course/presentation/bloc/my_course_state.dart';
import 'package:lms/feature/my_course/presentation/widgets/my_course_grid.dart';

class MyCoursePage extends StatelessWidget {
  const MyCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Courses'),
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
        child:
            BlocBuilder<MyCourseBloc, MyCourseState>(builder: (context, state) {
          if (state is MyCourseLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MyCourseFailure) {
            return Center(child: Text(state.message));
          }
          if (state is MyCourseSuccess) {
            return const MyCourseGrid();
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
