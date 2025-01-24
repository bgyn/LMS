import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/feature/auth/data/source/remote/supabse_auth_service.dart';
import 'package:lms/feature/auth/domain/model/user_model.dart';
import 'package:lms/feature/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl extends AuthRepository {
  final SupabaseAuthService _supabaseAuthService;
  AuthRepositoryImpl(this._supabaseAuthService);

  @override
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _supabaseAuthService.login(email, password);
      return right(result);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _supabaseAuthService.logout();
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
          await _supabaseAuthService.register(email, password, fullName);
      return right(result);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<User?> getCurrentUser() => _supabaseAuthService.getCurrentUser();
  
 
}
