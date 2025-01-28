import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/core/params/update_profile_params.dart';
import 'package:lms/core/usecase/usecase.dart';
import 'package:lms/feature/profile/domain/model/profile_model.dart';
import 'package:lms/feature/profile/domain/repository/profile_repository.dart';

class UpadateProfile extends UseCase<ProfileModel, UpdateProfileParams> {
  final ProfileRepository _repository;
  UpadateProfile(this._repository);
  @override
  Future<Either<Failure, ProfileModel>> call(UpdateProfileParams params) async {
    return await _repository.updateProfile(params);
  }
}
