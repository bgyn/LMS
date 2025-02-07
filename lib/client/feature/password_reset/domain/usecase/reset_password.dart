import 'package:fpdart/fpdart.dart';
import 'package:lms/shared/core/faliure/faliure.dart';
import 'package:lms/client/core/params/password_reset_params.dart';
import 'package:lms/shared/core/usecase/usecase.dart';
import 'package:lms/client/feature/password_reset/domain/repository/password_reset_repository.dart';

class ResetPassword extends UseCase<void, PasswordResetParams> {
  final PasswordResetRepository _repository;
  ResetPassword(this._repository);

  @override
  Future<Either<Failure, void>> call(PasswordResetParams params) async {
    return await _repository.resetPassword(params.email, params.password);
  }
}
