import 'package:lms/feature/auth/domain/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final Supabase _supabase = Supabase.instance;

  Stream<User?> getCurrentUser() => _supabase.client.auth.onAuthStateChange
      .map((event) => event.session?.user);

  Future<UserModel> login(String email, String password) async {
    try {
      final AuthResponse res = await _supabase.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = UserModel(
        id: res.user!.id,
        email: email,
        name: res.user!.userMetadata!["name"],
      );
      return user;
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<void> logout() async {
    try {
      await _supabase.client.auth.signOut();
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<UserModel> register(String email, String password, String name) async {
    try {
      final AuthResponse res = await _supabase.client.auth.signUp(
        data: {
          "name": name,
        },
        email: email,
        password: password,
      );
      // await _supabase.client.from("profile").insert(
      //   {
      //     "id": res.user!.id,
      //     "name": name,
      //     "email": email,
      //     "created_at": DateTime.now().toIso8601String(),
      //   },
      // );
      final user = UserModel(
        id: res.user!.id,
        email: email,
        name: name,
      );

      return user;
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
