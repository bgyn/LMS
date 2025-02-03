sealed class PasswordResetState {}

class PasswordInitial extends PasswordResetState {}

class PasswordResetLoading extends PasswordResetState {}

class PasswordResetRequestSuccess extends PasswordResetState {}

class PasswordOtpVerifySuccess extends PasswordResetState {}

class PasswordResetRequestFailure extends PasswordResetState {
  final String message;

  PasswordResetRequestFailure(this.message);
}

class PasswordOtpVerifyFailure extends PasswordResetState {
  final String message;

  PasswordOtpVerifyFailure(this.message);
}

class PasswordResetSuccess extends PasswordResetState {}

class PasswordResetFailure extends PasswordResetState {
  final String message;

  PasswordResetFailure(this.message);
}
