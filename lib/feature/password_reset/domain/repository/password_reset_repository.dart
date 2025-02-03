import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';

abstract class PasswordResetRepository {
  Future<Either<Failure, void>> sendPasswordResetRequest(String email);
  Future<Either<Failure, void>> resetPassword(String email, String password);
  Future<Either<Failure, void>> verifyOtp(String email, String otp);
}
