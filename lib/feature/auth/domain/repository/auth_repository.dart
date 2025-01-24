import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/feature/auth/domain/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword(
      String email, String password, String fullName);
  Future<Either<Failure, void>> signOut();

 Stream<User?> getCurrentUser();
}
