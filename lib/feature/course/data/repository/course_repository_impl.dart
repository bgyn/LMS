import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/feature/course/data/data/remote/course_api_service.dart';
import 'package:lms/feature/course/domain/model/course_model.dart';
import 'package:lms/feature/course/domain/repository/course_repository.dart';

class CourseRepositoryImpl extends CourseRepository {
  final CourseApiService _courseApiService;
  CourseRepositoryImpl(this._courseApiService);
  @override
  Future<Either<Failure, List<CourseModel>>> getCourses() async {
    try {
      final courses = await _courseApiService.getCourses();
      return Right(courses);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


}
