import 'package:lms/feature/profile/domain/model/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProfileService {
  final Supabase _supabase = Supabase.instance;
  Future<ProfileModel> getProfile() async {
    try {
      final data = await _supabase.client.from('users').select();
      final profile = ProfileModel.fromMap(data[0]);
      return profile;
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
