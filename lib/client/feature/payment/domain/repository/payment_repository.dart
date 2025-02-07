import 'package:fpdart/fpdart.dart';
import 'package:lms/shared/core/faliure/faliure.dart';
import 'package:lms/client/core/params/payment_intent_params.dart';

abstract class PaymentRepository {
  Future<Either<Failure, String>> createPaymentIntent(
      PaymentIntentParams params);
}
