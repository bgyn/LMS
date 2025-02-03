import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/feature/auth/domain/model/auth_response_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponseModel>> signInWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, AuthResponseModel>> signUpWithEmailAndPassword(
      String email, String password, String fullName);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, AuthResponseModel>> isUserLoggedIn();
}
