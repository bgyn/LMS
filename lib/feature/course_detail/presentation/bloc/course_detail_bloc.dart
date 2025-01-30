import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/feature/course_detail/domain/usecase/get_course_details_by_id.dart';
import 'package:lms/feature/course_detail/presentation/bloc/course_detail_event.dart';
import 'package:lms/feature/course_detail/presentation/bloc/course_detail_state.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  final GetCourseDetailsById _getCourseDetailsById;
  CourseDetailBloc(this._getCourseDetailsById) : super(CourseDetailInitial()) {
    on<FetchCourseDetailEvent>(_onGetCourseDetailsById);
  }

  void _onGetCourseDetailsById(
      FetchCourseDetailEvent event, Emitter<CourseDetailState> emit) async {
    emit(CourseDetailLoading());
    final result = await _getCourseDetailsById.call(event.courseId);
    result.fold((failure) => emit(CourseDetailError(failure.errorMessage)),
        (course) => emit(CourseDetailLoaded(course)));
  }
}
