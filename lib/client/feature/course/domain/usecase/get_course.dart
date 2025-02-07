import 'package:fpdart/fpdart.dart';
import 'package:lms/client/core/faliure/faliure.dart';
import 'package:lms/client/core/usecase/usecase.dart';
import 'package:lms/client/feature/course/domain/model/course_model.dart';
import 'package:lms/client/feature/course/domain/repository/course_repository.dart';

class GetCourse extends UseCase<List<CourseModel>, void> {
  final CourseRepository _courseRepository;
  GetCourse(this._courseRepository);
  @override
  Future<Either<Failure, List<CourseModel>>> call(void params) async {
    return await _courseRepository.getCourses();
  }
}
