import 'package:lms/core/params/sign_params.dart';
import 'package:lms/core/params/signup_params.dart';

sealed class AuthEvent {}

class AuthIsUserLoggedIn extends AuthEvent {}

class AuthIntialEvent extends AuthEvent {}

class AuthSignIn extends AuthEvent {
  final SiginParams params;
  AuthSignIn(this.params);
}

class AuthSignUp extends AuthEvent {
  final SigupParams params;
  AuthSignUp(this.params);
}

class AuthSignOut extends AuthEvent {}
