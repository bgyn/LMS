import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/core/params/payment_intent_params.dart';

abstract class PaymentRepository {
  Future<Either<Failure, String>> createPaymentIntent(
      PaymentIntentParams params);
}
