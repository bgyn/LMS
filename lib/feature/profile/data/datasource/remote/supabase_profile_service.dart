import 'package:lms/feature/profile/domain/model/profile_model.dart';

class SupabaseProfileService {
  Future<ProfileModel> getProfile() async {
    try {
      final profile = ProfileModel(
        id: "12342",
        name: "John Doe",
        email: "bigyanthanait8@gmail.com",
      );
      return profile;
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
