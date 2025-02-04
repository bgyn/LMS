import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/feature/my_course/data/source/remote/my_course_api_service.dart';
import 'package:lms/feature/my_course/domain/model/my_courses_model.dart';
import 'package:lms/feature/my_course/domain/repository/my_course_repository.dart';

class MyCourseRepositoryImpl extends MyCourseRepository {
  final MyCourseApiService _apiService;
  MyCourseRepositoryImpl(this._apiService);
  @override
  Future<Either<Failure, List<MyCourseModel>>> getMyCourses() async {
    try {
      final result = await _apiService.getMyCourses();
      return right(result);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
