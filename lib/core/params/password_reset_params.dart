class PasswordResetParams {
  final String email;
  final String password;
  final String token;

  PasswordResetParams(
      {required this.email, required this.password, required this.token});
}
