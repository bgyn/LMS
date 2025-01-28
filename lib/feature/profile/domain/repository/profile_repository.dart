import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/core/params/update_profile_params.dart';
import 'package:lms/feature/profile/domain/model/profile_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileModel>> getProfile();

  Future<Either<Failure, ProfileModel>> updateProfile(
      UpdateProfileParams params);
}
