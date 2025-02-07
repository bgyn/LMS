class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);
}

class UserAlreadyExistsException implements Exception {
  final String message;

  UserAlreadyExistsException(this.message);
}

class InvalidEmailOrPasswordException implements Exception {
  final String message;

  InvalidEmailOrPasswordException(this.message);
}

class UserNotLoggedInException implements Exception {
  final String message;

  UserNotLoggedInException(this.message);
}
