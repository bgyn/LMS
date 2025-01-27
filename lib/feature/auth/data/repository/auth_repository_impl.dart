import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/feature/auth/data/source/remote/auth_api_service.dart';
import 'package:lms/feature/auth/domain/model/auth_response_model.dart';
import 'package:lms/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApiService _authApiService;
  AuthRepositoryImpl(this._authApiService);

  @override
  Future<Either<Failure, AuthResponseModel>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _authApiService.login(email, password);
      return right(result);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authApiService.logout();
      return right(null);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseModel>> signUpWithEmailAndPassword(
      String email, String password, String fullName) async {
    try {
      final result =
          await _authApiService.register(email, password, fullName);
      return right(result);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }


}
