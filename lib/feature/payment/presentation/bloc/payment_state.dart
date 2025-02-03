sealed class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentIntentSuccess extends PaymentState {
  final String clientSecret;
  PaymentIntentSuccess(this.clientSecret);
}

class PaymentIntentError extends PaymentState {
  final String message;
  PaymentIntentError(this.message);
}

class PaymentSuccess extends PaymentState {
  PaymentSuccess();
}

class PaymentError extends PaymentState {
  final String message;
  PaymentError(this.message);
}
