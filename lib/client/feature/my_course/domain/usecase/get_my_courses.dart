import 'package:fpdart/fpdart.dart';
import 'package:lms/shared/core/faliure/faliure.dart';
import 'package:lms/shared/core/usecase/usecase.dart';
import 'package:lms/client/feature/my_course/domain/model/my_courses_model.dart';
import 'package:lms/client/feature/my_course/domain/repository/my_course_repository.dart';

class GetMyCourses extends UseCase<List<MyCourseModel>, void> {
  final MyCourseRepository _repository;
  GetMyCourses(this._repository);
  @override
  Future<Either<Failure, List<MyCourseModel>>> call(void params) async {
    return await _repository.getMyCourses();
  }
}
