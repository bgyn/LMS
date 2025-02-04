import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/feature/auth/data/source/localsource/auth_local_service.dart';
import 'package:lms/feature/auth/data/source/remote/auth_api_service.dart';
import 'package:lms/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApiService _authApiService;
  final LocalAuthApiService _localAuthApiService;
  AuthRepositoryImpl(this._authApiService, this._localAuthApiService);

  @override
  Future<Either<Failure, void>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _authApiService.login(email, password);
      _localAuthApiService.saveAccessToken(result.accessToken!);
      _localAuthApiService.saveRefreshToken(result.refreshToken!);
      return right(null);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      _localAuthApiService.deleteToken();
      return right(null);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signUpWithEmailAndPassword(
      String email, String password, String fullName) async {
    try {
      final result = await _authApiService.register(email, password, fullName);
      _localAuthApiService.saveAccessToken(result.accessToken!);
      _localAuthApiService.saveRefreshToken(result.refreshToken!);
      return right(null);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> isUserLoggedIn() async {
    try {
      final result = await _authApiService.verifyToken();
      if (result != null) {
        _localAuthApiService.saveAccessToken(result);
      }
      return right(null);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
