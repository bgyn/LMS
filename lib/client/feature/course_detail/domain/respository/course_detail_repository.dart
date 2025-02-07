import 'package:fpdart/fpdart.dart';
import 'package:lms/client/core/faliure/faliure.dart';
import 'package:lms/client/feature/course/domain/model/course_model.dart';

abstract class CourseDetailRepository {
  Future<Either<Failure, CourseModel>> getCourseDetailById(String id);
}