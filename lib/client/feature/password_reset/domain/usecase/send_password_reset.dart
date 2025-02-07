import 'package:fpdart/fpdart.dart';
import 'package:lms/shared/core/faliure/faliure.dart';
import 'package:lms/shared/core/usecase/usecase.dart';
import 'package:lms/client/feature/password_reset/domain/repository/password_reset_repository.dart';

class SendPasswordReset extends UseCase<void, String> {
  final PasswordResetRepository repository;

  SendPasswordReset(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.sendPasswordResetRequest(params);
  }
}
