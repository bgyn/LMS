
sealed class AuthState {
  final String? errorMessage;
  AuthState({ this.errorMessage});
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLogginIn extends AuthState {}

class Authenticated extends AuthState {
  Authenticated() : super();
}

class AuthSignedOut extends AuthState {}

class Unauthenticated extends AuthState {
  Unauthenticated(String errorMessage) : super(errorMessage: errorMessage);
}

//state for forgot password error and verify otp error and password reser error
class AuthError extends AuthState {
  AuthError(String errorMessage) : super(errorMessage: errorMessage);
}
