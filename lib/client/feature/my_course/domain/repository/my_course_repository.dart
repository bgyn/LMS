import 'package:fpdart/fpdart.dart';
import 'package:lms/shared/core/faliure/faliure.dart';
import 'package:lms/client/feature/my_course/domain/model/my_courses_model.dart';

abstract class MyCourseRepository {
  Future<Either<Failure, List<MyCourseModel>>> getMyCourses();
}
