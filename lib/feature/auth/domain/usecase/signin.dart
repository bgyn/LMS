import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/core/params/sign_params.dart';
import 'package:lms/core/usecase/usecase.dart';
import 'package:lms/feature/auth/domain/repository/auth_repository.dart';

class Singin extends UseCase<void, SiginParams> {
  final AuthRepository _authRepository;
  Singin(this._authRepository);
  @override
  Future<Either<Failure, void>> call(SiginParams params) async {
    return await _authRepository.signInWithEmailAndPassword(
        params.email, params.password);
  }
}
