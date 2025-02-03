import 'package:flutter/material.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/feature/course/domain/model/course_model.dart';

class Overview extends StatelessWidget {
  final CourseModel course;
  const Overview({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 0.02.h(context),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Overview",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          course.title!,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontSize: 0.018.toRes(context)),
        ),
        Row(
          children: [
            Text(
              "Course Rating : ",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            ...List.generate(4, (index) => const Icon(Icons.star)),
          ],
        ),
        RichText(
            text: TextSpan(
          children: [
            TextSpan(
                text: "Course Time : ",
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
              text: "8 Weeks",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        )),
        RichText(
            text: TextSpan(
          children: [
            TextSpan(
                text: "Course Trainer : ",
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
              text: course.instructor!.name!,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        )),
        SizedBox(
          height: 0.01.h(context),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 0.15.h(context),
              padding: EdgeInsets.symmetric(
                  vertical: 0.02.h(context), horizontal: 0.07.w(context)),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date : ${DateTime.now().toCustomFormat()}",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(fontSize: 0.012.toRes(context)),
                      ),
                      Text(
                        "Price : ${course.price}",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(fontSize: 0.012.toRes(context)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Coupon : 10% Off",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(fontSize: 0.012.toRes(context)),
                      ),
                      Text(
                        "Final Price : ${course.price! * 0.9}",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(fontSize: 0.012.toRes(context)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: -15,
              left: 20,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 0.01.w(context)),
                child: Text(
                  "Purchase Details",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
