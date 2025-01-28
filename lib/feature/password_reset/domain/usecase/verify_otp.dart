import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/core/params/verify_otp_params.dart';
import 'package:lms/core/usecase/usecase.dart';
import 'package:lms/feature/password_reset/domain/repository/password_reset_repository.dart';

class VerifyOtp extends UseCase<void,VerifyOtpParams>{
  final PasswordResetRepository _repository;
  VerifyOtp(this._repository);
  @override
  Future<Either<Failure, void>> call(VerifyOtpParams params) async{
    return await _repository.verifyOtp(params.email, params.otp);
  }

}