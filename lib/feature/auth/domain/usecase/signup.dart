import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/core/params/signup_params.dart';
import 'package:lms/core/usecase/usecase.dart';
import 'package:lms/feature/auth/domain/model/user_model.dart';
import 'package:lms/feature/auth/domain/repository/auth_repository.dart';

class Signup extends UseCase<void, SigupParams> {
  final AuthRepository _authRepository;

  Signup(this._authRepository);
  @override
  Future<Either<Failure, UserModel>> call(SigupParams params) {
    return _authRepository.signUpWithEmailAndPassword(
        params.email, params.password, params.name);
  }
}
