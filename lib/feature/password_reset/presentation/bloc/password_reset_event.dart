sealed class PasswordResetEvent {}

class PasswordResetSubmitted extends PasswordResetEvent {
  final String email;

  PasswordResetSubmitted(this.email);
}

class PasswordResetOtpVerify extends PasswordResetEvent {
  final String email;
  final String otp;

  PasswordResetOtpVerify(this.email, this.otp);
}

class PasswordResetOtpResend extends PasswordResetEvent {
  final String email;

  PasswordResetOtpResend(this.email);
}

class PasswordReset extends PasswordResetEvent {
  final String email;
  final String password;
  final String token;

  PasswordReset(this.email, this.password,this.token);
}
