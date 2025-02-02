import 'package:flutter/material.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/feature/course/domain/model/course_model.dart';
import 'package:lms/feature/course_detail/presentation/widgets/lessons_tab.dart';
import 'package:lms/feature/course_detail/presentation/widgets/overview_tab.dart';
import 'package:lms/feature/course_detail/presentation/widgets/reviews_tab.dart';

class CourseTabbar extends StatefulWidget {
  final CourseModel course;
  const CourseTabbar({super.key, required this.course});

  @override
  State<CourseTabbar> createState() => _CourseTabbarState();
}

class _CourseTabbarState extends State<CourseTabbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicator: const BoxDecoration(
            color: ColorPalette.primaryColor,
          ),
          enableFeedback: false,
          splashFactory: NoSplash.splashFactory,
          tabs: [
            Tab(
              child: Text(
                "Overview",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color:
                        _tabController.index == 0 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Tab(
              child: Text(
                "Lessons",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color:
                        _tabController.index == 1 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Tab(
              child: Text(
                "Reviews",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color:
                        _tabController.index == 2 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        Expanded(
            child: TabBarView(controller: _tabController, children: [
          OverviewTab(
              title: widget.course.title.toString(),
              description: widget.course.description.toString(),
              price: widget.course.price!,
              instructor: widget.course.instructor!),
          LessonsTab(
            lessons: widget.course.lessons!,
          ),
          const ReviewsTab(),
        ])),
      ],
    );
  }
}
