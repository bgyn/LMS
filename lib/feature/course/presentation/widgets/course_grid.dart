import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/config/route/route_path.dart';
import 'package:lms/core/constants/url_constant.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/feature/course/presentation/bloc/course_bloc.dart';
import 'package:lms/feature/course/presentation/bloc/course_state.dart';

class CourseGrid extends StatelessWidget {
  const CourseGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseState>(
      builder: (context, state) {
        if (state is CourseLoaded) {
          return GridView.builder(
            itemCount: state.courses!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10, // Add horizontal spacing between items
              mainAxisSpacing: 10, // Add vertical spacing between items
            ),
            itemBuilder: (context, index) {
              final course = state.courses![index];
              return GestureDetector(
                onTap: () =>
                    context.push(RoutePath.courseDetail, extra: course.id),
                child: Card(
                  elevation: 5, // Add shadow for a card-like effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15), // Rounded corners for the card
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        15), // Ensure image and content inside also have rounded corners
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double imageHeight = constraints.maxWidth / (1 / 0.8);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  UrlConstant.mediaUrl + course.thumbnail!,
                              width: double.infinity,
                              height: imageHeight,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error, size: 50),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course.title!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontSize:
                                              16, // Larger font size for the title
                                          fontWeight:
                                              FontWeight.bold, // Bold title
                                          color: Colors
                                              .black, // Set color to black for better visibility
                                        ),
                                  ),
                                  SizedBox(height: 0.001.h(context)),
                                  Text(
                                    "By ${course.instructor!.name!}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: Colors.grey[
                                              600], // Darker grey for better readability
                                          fontSize: 14,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
