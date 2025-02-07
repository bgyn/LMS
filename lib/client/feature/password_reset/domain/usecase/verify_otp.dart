import 'package:fpdart/fpdart.dart';
import 'package:lms/client/core/faliure/faliure.dart';
import 'package:lms/client/core/params/verify_otp_params.dart';
import 'package:lms/client/core/usecase/usecase.dart';
import 'package:lms/client/feature/password_reset/domain/repository/password_reset_repository.dart';

class VerifyOtp extends UseCase<void,VerifyOtpParams>{
  final PasswordResetRepository _repository;
  VerifyOtp(this._repository);
  @override
  Future<Either<Failure, void>> call(VerifyOtpParams params) async{
    return await _repository.verifyOtp(params.email, params.otp);
  }

}