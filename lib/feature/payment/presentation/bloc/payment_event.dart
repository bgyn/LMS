sealed class PaymentEvent {}

class PaymentIntent extends PaymentEvent {
  final String amount;
  final String courseId;
  PaymentIntent(this.amount, this.courseId);
}
