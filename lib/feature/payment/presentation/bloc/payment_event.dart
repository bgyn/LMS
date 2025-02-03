sealed class PaymentEvent {}

class InitiatePaymentIntent extends PaymentEvent {
  final String amount;
  final String courseId;
  InitiatePaymentIntent(this.amount, this.courseId);
}

class PaymentSuccessEvent extends PaymentEvent {
  PaymentSuccessEvent();
}
