import 'package:fpdart/fpdart.dart';
import 'package:lms/shared/core/faliure/faliure.dart';
import 'package:lms/shared/core/usecase/usecase.dart';
import 'package:lms/client/feature/profile/domain/model/profile_model.dart';
import 'package:lms/client/feature/profile/domain/repository/profile_repository.dart';

class GetProfile extends UseCase<ProfileModel, void> {
  final ProfileRepository _repository;
  GetProfile(this._repository);
  @override
  Future<Either<Failure, ProfileModel>> call(void params) {
    return _repository.getProfile();
  }
}
