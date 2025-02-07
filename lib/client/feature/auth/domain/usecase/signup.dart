import 'package:fpdart/fpdart.dart';
import 'package:lms/shared/core/faliure/faliure.dart';
import 'package:lms/client/core/params/signup_params.dart';
import 'package:lms/shared/core/usecase/usecase.dart';
import 'package:lms/client/feature/auth/domain/repository/auth_repository.dart';

class Signup extends UseCase<void, SigupParams> {
  final AuthRepository _authRepository;

  Signup(this._authRepository);
  @override
  Future<Either<Failure, void>> call(SigupParams params) {
    return _authRepository.signUpWithEmailAndPassword(
        params.email, params.password, params.name);
  }
}
