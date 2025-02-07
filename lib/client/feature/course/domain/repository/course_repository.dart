import 'package:fpdart/fpdart.dart';
import 'package:lms/shared/core/faliure/faliure.dart';
import 'package:lms/client/feature/course/domain/model/course_model.dart';

abstract class CourseRepository {
  Future<Either<Failure, List<CourseModel>>> getCourses();

}
