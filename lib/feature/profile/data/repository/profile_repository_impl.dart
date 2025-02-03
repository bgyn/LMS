import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/core/params/update_profile_params.dart';
import 'package:lms/feature/profile/data/datasource/remote/profile_api_service.dart';
import 'package:lms/feature/profile/domain/model/profile_model.dart';
import 'package:lms/feature/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileApiService _profileService;
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

  @override
  Future<Either<Failure, ProfileModel>> updateProfile(
      UpdateProfileParams params) async {
    try {
      final profile = await _profileService.updateProfile(
        file: params.profileImage,
        name: params.name,
        bio: params.bio,
      );
      return right(profile);
    } catch (e) {
      return left(ServerFailure("Unexpected error: $e"));
    }
  }
}
