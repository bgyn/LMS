import 'package:fpdart/fpdart.dart';
import 'package:lms/client/core/faliure/faliure.dart';
import 'package:lms/client/core/params/payment_intent_params.dart';
import 'package:lms/client/core/usecase/usecase.dart';
import 'package:lms/client/feature/payment/domain/repository/payment_repository.dart';

class CreatePaymentIntent extends UseCase<String, PaymentIntentParams> {
  final PaymentRepository _repository;
  CreatePaymentIntent(this._repository);
  @override
  Future<Either<Failure, String>> call(PaymentIntentParams params) async {
    return await _repository.createPaymentIntent(params);
  }
}
