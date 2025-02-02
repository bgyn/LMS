import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/core/params/sign_params.dart';
import 'package:lms/core/usecase/usecase.dart';
import 'package:lms/feature/auth/domain/model/auth_response_model.dart';
import 'package:lms/feature/auth/domain/repository/auth_repository.dart';

class Singin extends UseCase<AuthResponseModel, SiginParams> {
  final AuthRepository _authRepository;
  Singin(this._authRepository);
  @override
  Future<Either<Failure, AuthResponseModel>> call(SiginParams params) async {
    return await _authRepository.signInWithEmailAndPassword(
        params.email, params.password);
  }
}
