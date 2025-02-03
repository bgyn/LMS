import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/feature/course/domain/model/course_model.dart';
import 'package:lms/feature/course_detail/data/source/remote/course_detail_api_service.dart';
import 'package:lms/feature/course_detail/domain/respository/course_detail_repository.dart';

class CourseDetailRepositoryImpl extends CourseDetailRepository {
  final CourseDetailApiService _courseDetailApiService;
  CourseDetailRepositoryImpl(this._courseDetailApiService);

  @override
  Future<Either<Failure, CourseModel>> getCourseDetailById(String id) async {
    try {
      final course = await _courseDetailApiService.getCourseById(id);
      return Right(course);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
