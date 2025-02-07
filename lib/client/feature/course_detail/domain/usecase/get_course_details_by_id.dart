import 'package:fpdart/fpdart.dart';
import 'package:lms/client/core/faliure/faliure.dart';
import 'package:lms/client/core/usecase/usecase.dart';
import 'package:lms/client/feature/course/domain/model/course_model.dart';
import 'package:lms/client/feature/course_detail/domain/respository/course_detail_repository.dart';

class GetCourseDetailsById extends UseCase<CourseModel,String>{
  final CourseDetailRepository _courseDetailRepository;
  GetCourseDetailsById(this._courseDetailRepository);

  @override
  Future<Either<Failure, CourseModel>> call(String params) async{
    return await _courseDetailRepository.getCourseDetailById(params);
  }
  
}