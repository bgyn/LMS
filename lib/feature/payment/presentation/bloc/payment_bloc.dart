import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/params/payment_intent_params.dart';
import 'package:lms/feature/payment/domain/usecase/create_payment_intent.dart';
import 'package:lms/feature/payment/presentation/bloc/payment_event.dart';
import 'package:lms/feature/payment/presentation/bloc/payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final CreatePaymentIntent _createPaymentIntent;
  PaymentBloc(this._createPaymentIntent) : super(PaymentInitial()) {
    on<InitiatePaymentIntent>(_onPaymentIntent);
    on<PaymentSuccessEvent>(_onPaymentSuccess);
  }

  void _onPaymentIntent(
      InitiatePaymentIntent event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());
    final result = await _createPaymentIntent(
        PaymentIntentParams(amount: event.amount, courseId: event.courseId));
    result.fold(
      (failure) => emit(PaymentError(failure.errorMessage)),
      (response) => emit(PaymentIntentSuccess(response)),
    );
  }

  void _onPaymentSuccess(
      PaymentSuccessEvent event, Emitter<PaymentState> emit) async {
    emit(PaymentSuccess());
  }
}
