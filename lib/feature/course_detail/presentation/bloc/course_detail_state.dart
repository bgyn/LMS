import 'package:lms/feature/course/domain/model/course_model.dart';

sealed class CourseDetailState {}

class CourseDetailInitial extends CourseDetailState {}

class CourseDetailLoading extends CourseDetailState {}

class CourseDetailLoaded extends CourseDetailState {
  final CourseModel course;
  CourseDetailLoaded(this.course);
}

class CourseDetailError extends CourseDetailState {
  final String message;
  CourseDetailError(this.message);
}
