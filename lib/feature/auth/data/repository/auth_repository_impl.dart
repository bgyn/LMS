import 'package:fpdart/fpdart.dart';
import 'package:lms/core/exceptions/exceptions.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/feature/auth/data/source/remote/appwrite_auth_service.dart';
import 'package:lms/feature/auth/domain/model/user_model.dart';
import 'package:lms/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AppwriteAuthService _appwriteAuthService;
  AuthRepositoryImpl(this._appwriteAuthService);
  @override
  Future<Either<Failure, UserModel>> isUserLoggedIn() async {
    try {
      final result = await _appwriteAuthService.isUserLoggedIn();
      return right(result);
    } on UnauthorizedException catch (e) {
      return left(UnAuthorizedFailure(e.message));
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _appwriteAuthService.login(email, password);
      return right(result);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _appwriteAuthService.logout();
      return right(null);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword(
      String email, String password, String fullName) async {
    try {
      final result =
          await _appwriteAuthService.register(email, password, fullName);
      return right(result);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
