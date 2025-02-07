import 'package:fpdart/fpdart.dart';
import 'package:lms/client/core/faliure/faliure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}