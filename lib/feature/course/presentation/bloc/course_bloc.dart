import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/feature/course/domain/usecase/get_course.dart';
import 'package:lms/feature/course/presentation/bloc/course_event.dart';
import 'package:lms/feature/course/presentation/bloc/course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetCourse _getCourse;
  CourseBloc(this._getCourse) : super(CourseInitial()) {
    on<FetchCourses>(_onGetCourse);
  }

  void _onGetCourse(FetchCourses event, Emitter<CourseState> emit) async {
    emit(CourseLoading());
    final result = await _getCourse.call(null);
    result.fold((failure) => emit(CourseError(failure.errorMessage)),
        (courses) => emit(CourseLoaded(courses: courses)));
  }
}
