import 'package:fpdart/fpdart.dart';
import 'package:lms/client/core/faliure/faliure.dart';
import 'package:lms/client/core/params/update_profile_params.dart';
import 'package:lms/client/core/usecase/usecase.dart';
import 'package:lms/client/feature/profile/domain/model/profile_model.dart';
import 'package:lms/client/feature/profile/domain/repository/profile_repository.dart';

class GetProfile extends UseCase<ProfileModel,UpdateProfileParams>{
  final ProfileRepository _repository;
  GetProfile(this._repository);
  @override
  Future<Either<Failure, ProfileModel>> call(void params) {
    return _repository.getProfile();
  }
  
}