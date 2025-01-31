import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/core/params/payment_intent_params.dart';
import 'package:lms/core/usecase/usecase.dart';
import 'package:lms/feature/payment/domain/repository/payment_repository.dart';

class CreatePaymentIntent extends UseCase<String, PaymentIntentParams> {
  final PaymentRepository _repository;
  CreatePaymentIntent(this._repository);
  @override
  Future<Either<Failure, String>> call(PaymentIntentParams params) async {
    return await _repository.createPaymentIntent(params);
  }
}
