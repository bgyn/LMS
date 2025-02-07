import 'package:fpdart/fpdart.dart';
import 'package:lms/shared/core/faliure/faliure.dart';
import 'package:lms/shared/core/usecase/usecase.dart';
import 'package:lms/client/feature/auth/domain/repository/auth_repository.dart';

class Singout extends UseCase<void, void> {
  final AuthRepository _authRepository;
  Singout(this._authRepository);
  @override
  Future<Either<Failure, void>> call(void params) async {
    return await _authRepository.signOut();
  }
}
