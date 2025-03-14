import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/feature/password_reset/data/source/remote/password_reset_api_service.dart';
import 'package:lms/feature/password_reset/domain/repository/password_reset_repository.dart';

class PasswordResetRepositoryImpl extends PasswordResetRepository {
  final PasswordResetApiService _passwordResetApiService;
  PasswordResetRepositoryImpl(this._passwordResetApiService);
  @override
  Future<Either<Failure, void>> resetPassword(
      String email, String password,String token) async {
    try {
      await _passwordResetApiService.passwordReset(email, password,token);
      return right(null);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetRequest(String email) async {
    try {
      await _passwordResetApiService.sendPasswordResetRequest(email);
      return right(null);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp(String email, String otp) async {
    try {
      final result = await _passwordResetApiService.verifyOtp(email, otp);
      return right(result);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
