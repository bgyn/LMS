import 'package:lms/feature/my_course/domain/model/my_courses_model.dart';

sealed class MyCourseState {}

class MyCourseInitial extends MyCourseState {}

class MyCourseLoading extends MyCourseState {}

class MyCourseSuccess extends MyCourseState {
  final List<MyCourseModel> myCourses;
  MyCourseSuccess(this.myCourses);
}

class MyCourseFailure extends MyCourseState {
  final String message;
  MyCourseFailure(this.message);
}
