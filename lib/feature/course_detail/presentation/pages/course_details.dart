import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/config/route/route_path.dart';
import 'package:lms/core/constants/url_constant.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/core/widgets/button.dart';
import 'package:lms/feature/course_detail/presentation/bloc/course_detail_bloc.dart';
import 'package:lms/feature/course_detail/presentation/bloc/course_detail_event.dart';
import 'package:lms/feature/course_detail/presentation/bloc/course_detail_state.dart';
import 'package:lms/feature/course_detail/presentation/widgets/course_tabbar.dart';
import 'package:lms/feature/my_course/presentation/bloc/my_course_bloc.dart';
import 'package:lms/feature/my_course/presentation/bloc/my_course_state.dart';
import 'package:lms/injection_container.dart';

class CourseDetails extends StatelessWidget {
  final String id;
  const CourseDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final mycourseState = context.read<MyCourseBloc>().state;
    return BlocProvider(
      create: (_) => CourseDetailBloc(sl())..add(FetchCourseDetailEvent(id)),
      child: BlocBuilder<CourseDetailBloc, CourseDetailState>(
          builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: state is CourseDetailLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state is CourseDetailLoaded
                    ? Column(
                        children: [
                          Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: UrlConstant.mediaUrl +
                                    state.course.thumbnail!,
                                width: double.infinity,
                                height: 0.25.h(context),
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error, size: 50),
                              ),
                              Positioned(
                                top: -10,
                                left: 0,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    context.pop();
                                  },
                                ),
                              ),
                              Positioned(
                                top: -10,
                                right: 0,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.bookmark,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                              child: CourseTabbar(
                            course: state.course,
                          )),
                          mycourseState is MyCourseSuccess
                              ? Visibility(
                                  visible: !mycourseState.myCourses.any(
                                      (element) => element.course!.id == id),
                                  child: SizedBox(
                                    height: 0.1.h(context),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      )
                    : const Center(
                        child: Text("Error"),
                      ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: mycourseState is MyCourseSuccess
              ? Visibility(
                  visible: !mycourseState.myCourses
                      .any((element) => element.course!.id == id),
                  child: Button(
                      width: 0.9.w(context),
                      title: "Enroll",
                      onTap: () {
                        if (state is CourseDetailLoaded) {
                          context.push(RoutePath.paymentIntent,
                              extra: jsonEncode({
                                "amount": state.course.price,
                                "courseId": state.course.id,
                                "course": jsonEncode(state.course.toJson())
                              }));
                        }
                      }))
              : const SizedBox.shrink(),
        );
      }),
    );
  }
}
