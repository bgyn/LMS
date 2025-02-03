import 'package:flutter/material.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/feature/course/domain/model/lesson_model.dart';
import 'package:lms/feature/course_detail/presentation/widgets/sub_lession_card.dart';

class LessonsTab extends StatelessWidget {
  final List<LessonModel> lessons;
  final String courseId;

  const LessonsTab({super.key, required this.lessons, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 3,
                    surfaceTintColor: ColorPalette.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tilePadding: const EdgeInsets.all(12.0),
                      title: Row(
                        children: [
                          // Modern Leading Widget
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: ColorPalette.primaryColor.withAlpha(40),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.play_circle_filled,
                              color: ColorPalette.primaryColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Chapter ${index + 1}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  lessons[index].description.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      children: [
                        SubLessonCard(
                            courseId: courseId,
                            subLessons: lessons[index].subLessons!),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
