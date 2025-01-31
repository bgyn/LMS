import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/core/params/payment_intent_params.dart';
import 'package:lms/feature/payment/data/source/remote/payment_api_service.dart';
import 'package:lms/feature/payment/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentApiService _apiService;
  PaymentRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, String>> createPaymentIntent(
      PaymentIntentParams params) async {
    try {
      final response =
          await _apiService.createPaymentIntent(params.amount, params.courseId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
