import 'package:lms/feature/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Getcurrentuser {
  final AuthRepository _authRepository;
  Getcurrentuser(this._authRepository);
  Stream<User?> get getCurrentUser => _authRepository.getCurrentUser();
}
