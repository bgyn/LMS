import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/feature/my_course/domain/usecase/get_my_courses.dart';
import 'package:lms/feature/my_course/presentation/bloc/my_course_event.dart';
import 'package:lms/feature/my_course/presentation/bloc/my_course_state.dart';

class MyCourseBloc extends Bloc<MyCourseEvent, MyCourseState> {
  final GetMyCourses _getMyCourses;
  MyCourseBloc(this._getMyCourses) : super(MyCourseInitial()) {
    on<FetchMyCourse>(_fetchMyCourse);
  }

  void _fetchMyCourse(FetchMyCourse event, Emitter<MyCourseState> emit) async {
    emit(MyCourseLoading());
    final result = await _getMyCourses.call(null);
    result.fold(
      (failure) => emit(MyCourseFailure(failure.errorMessage)),
      (myCourses) => emit(MyCourseSuccess(myCourses)),
    );
  }
}
