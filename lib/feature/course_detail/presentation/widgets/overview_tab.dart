import 'package:flutter/material.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/feature/course/domain/model/course_model.dart';

class OverviewTab extends StatelessWidget {
  final String title;
  final String description;
  final InstructorModel instructor;
  final int price;

  const OverviewTab(
      {super.key,
      required this.title,
      required this.price,
      required this.description,
      required this.instructor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.01.h(context),
          ),
          Text(
            "\$ $price",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 0.018.toRes(context),
                ),
          ),
          SizedBox(
            height: 0.01.h(context),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 0.018.toRes(context),
                ),
          ),
          Text(
            "By ${instructor.name}",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.grey[600],
                  fontSize: 0.012.toRes(context),
                ),
          ),
          SizedBox(
            height: 0.02.h(context),
          ),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 0.013.toRes(context),
                ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
