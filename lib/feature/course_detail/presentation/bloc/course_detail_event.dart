class CourseDetailEvent {}

class FetchCourseDetailEvent extends CourseDetailEvent {
  final String courseId;

  FetchCourseDetailEvent(this.courseId);
}
