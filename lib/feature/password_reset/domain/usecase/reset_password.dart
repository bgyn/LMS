import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/core/params/password_reset_params.dart';
import 'package:lms/core/usecase/usecase.dart';
import 'package:lms/feature/password_reset/domain/repository/password_reset_repository.dart';

class ResetPassword extends UseCase<void, PasswordResetParams> {
  final PasswordResetRepository _repository;
  ResetPassword(this._repository);

  @override
  Future<Either<Failure, void>> call(PasswordResetParams params) async {
    return await _repository.resetPassword(params.email, params.password,params.token);
  }
}
