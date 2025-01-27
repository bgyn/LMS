import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/feature/auth/data/source/localsource/auth_local_service.dart';
import 'package:lms/feature/auth/data/source/remote/auth_api_service.dart';
import 'package:lms/feature/auth/domain/model/auth_response_model.dart';
import 'package:lms/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApiService _authApiService;
  final LocalAuthApiService _localAuthApiService;
  AuthRepositoryImpl(this._authApiService, this._localAuthApiService);

  @override
  Future<Either<Failure, AuthResponseModel>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _authApiService.login(email, password);
      _localAuthApiService.saveToken(result.accessToken);
      return right(result);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authApiService.logout();
      _localAuthApiService.deleteToken();
      return right(null);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseModel>> signUpWithEmailAndPassword(
      String email, String password, String fullName) async {
    try {
      final result = await _authApiService.register(email, password, fullName);
      _localAuthApiService.saveToken(result.accessToken);
      return right(result);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseModel>> isUserLoggedIn() async {
    try {
      final result = await _localAuthApiService.isUserLoggedIn();
      if (result != null) {
        return right(AuthResponseModel(accessToken: result));
      }
      return left(const ServerFailure("User not logged in"));
    } on Exception catch (e) {
      print(e);
      return left(ServerFailure(e.toString()));
    }
  }
}
