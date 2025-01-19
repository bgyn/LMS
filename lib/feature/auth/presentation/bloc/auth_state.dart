import 'package:lms/feature/auth/domain/model/user_model.dart';

sealed class AuthState {
  final UserModel? user;
  final String? errorMessage;
  AuthState({this.user, this.errorMessage});
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLogginIn extends AuthState {}

class Authenticated extends AuthState {
  Authenticated(UserModel user) : super(user: user);
}

class AuthSignedOut extends AuthState {}

class Unauthenticated extends AuthState {
  Unauthenticated(String errorMessage) : super(errorMessage: errorMessage);
}
