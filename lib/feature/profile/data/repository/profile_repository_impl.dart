import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/feature/profile/data/datasource/remote/supabase_profile_service.dart';
import 'package:lms/feature/profile/domain/model/profile_model.dart';
import 'package:lms/feature/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final SupabaseProfileService _profileService;
  ProfileRepositoryImpl(this._profileService);
  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      final profile = await _profileService.getProfile();
      return right(profile);
    } catch (e) {
      return left(ServerFailure("Unexpected error: $e"));
    }
  }
}
