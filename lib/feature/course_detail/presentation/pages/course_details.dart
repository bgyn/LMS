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
import 'package:lms/injection_container.dart';

class CourseDetails extends StatelessWidget {
  final String id;
  const CourseDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CourseDetailBloc(sl())..add(FetchCourseDetailEvent(id)),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<CourseDetailBloc, CourseDetailState>(
              builder: (context, state) {
            if (state is CourseDetailLoaded) {
              return Column(
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            UrlConstant.mediaUrl + state.course.thumbnail!,
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
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Button(
            width: 0.9.w(context),
            title: "Enroll",
            onTap: () {
              context.push(RoutePath.paymentIntent);
            }),
      ),
    );
  }
}
