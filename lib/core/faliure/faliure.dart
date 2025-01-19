import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;

  const Failure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class NetworkFailure extends Failure {
  final String msg;
  const NetworkFailure(this.msg) : super(msg);
}

class AuthFailure extends Failure {
  final String msg;
  const AuthFailure(this.msg) : super(msg);
}

class UnAuthorizedFailure extends Failure {
  final String msg;
  const UnAuthorizedFailure(this.msg) : super(msg);
}

class ServerFailure extends Failure {
  final String msg;
  const ServerFailure(this.msg) : super(msg);
}
