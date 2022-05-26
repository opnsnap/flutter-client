/// Invalid session token.
class UnauthorizedException implements Exception {}

/// Invalid credentials when sign in/sign u
class InvalidCredentialsException implements Exception {
  final Map<String, String> errors;

  InvalidCredentialsException(this.errors);
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);
}
