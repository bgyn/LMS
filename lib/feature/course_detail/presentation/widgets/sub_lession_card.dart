import 'package:flutter/material.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/feature/course/domain/model/lesson_model.dart';
import 'package:lms/feature/video_player/presentation/widget/video_player_screen.dart';

class SubLessonCard extends StatelessWidget {
  final List<SubLesson> subLessons;

  const SubLessonCard({super.key, required this.subLessons});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: subLessons.length,
          itemBuilder: (context, index) {
            final subLesson = subLessons[index];

            return ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ColorPalette.primaryColor.withAlpha(40),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.play_circle_fill,
                  color: ColorPalette.primaryColor,
                  size: 24,
                ),
              ),
              title: Text(
                subLesson.title ?? "Untitled",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 0.012.toRes(context)),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.play_arrow,
                    color: ColorPalette.primaryColor),
                onPressed: () {
                  showVideoDialog(subLesson.video!.url.toString(), context);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
