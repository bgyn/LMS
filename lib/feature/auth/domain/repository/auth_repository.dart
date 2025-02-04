import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signInWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, void>> signUpWithEmailAndPassword(
      String email, String password, String fullName);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, void>> isUserLoggedIn();
}
