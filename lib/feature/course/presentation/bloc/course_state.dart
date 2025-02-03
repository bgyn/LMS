import 'package:lms/feature/course/domain/model/course_model.dart';

sealed class CourseState {}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {
  final List<CourseModel>? courses;
  CourseLoaded({this.courses});
}

class CourseError extends CourseState {
  final String message;
  CourseError(this.message);
}
