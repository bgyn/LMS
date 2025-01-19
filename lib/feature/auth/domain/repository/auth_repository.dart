import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/feature/auth/domain/model/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword(
      String email, String password, String fullName);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserModel>> isUserLoggedIn();
}
