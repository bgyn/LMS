sealed class StripeState {}

class StripeInitial extends StripeState {}

class StripeLoading extends StripeState {}

class StripePaymentSheetReady extends StripeState {}

class StripePaymentScuccess extends StripeState {}

class StripePaymentSheetError extends StripeState {
  final String message;

  StripePaymentSheetError(this.message);
}
