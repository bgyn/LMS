import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/core/usecase/usecase.dart';
import 'package:lms/feature/course/domain/model/course_model.dart';
import 'package:lms/feature/course/domain/repository/course_repository.dart';

class GetCourse extends UseCase<List<CourseModel>, void> {
  final CourseRepository _courseRepository;
  GetCourse(this._courseRepository);
  @override
  Future<Either<Failure, List<CourseModel>>> call(void params) async {
    return await _courseRepository.getCourses();
  }
}
