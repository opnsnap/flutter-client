part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  final String? message;
  const AuthState([this.message]);

  @override
  List<Object?> get props => [message];
}

class AuthUninitialized extends AuthState {
  //the app was just started

  const AuthUninitialized([String? message]) : super(message);
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated([String? message]) : super(message);
}

class AuthAuthenticated extends AuthState {
  final String email;
  final String id;
  final String token;

  const AuthAuthenticated(
      {required this.email,
        required this.id,
        required this.token,
        String? message})
      : super(message);

  @override
  List<Object?> get props => [email, id, token, message];
}

class AuthLoginInitialized extends AuthState {
  final String flowId;
  final String email;
  final String emailError;
  final String password;
  final String passwordError;
  final String generalError;

  const AuthLoginInitialized(
      {required this.flowId,
        this.email = "",
        this.emailError = "",
        this.password = "",
        this.passwordError = "",
        this.generalError = "",
        String? message})
      : super(message);

  @override
  List<Object?> get props =>
      [flowId, email, emailError, password, passwordError, generalError, message];
}

class AuthRegistrationInitialized extends AuthState {
  final String flowId;
  final String email;
  final String emailError;
  final String password;
  final String passwordError;
  final String generalError;

  const AuthRegistrationInitialized(
      {required this.flowId,
        this.email = "",
        this.emailError = "",
        this.password = "",
        this.passwordError = "",
        this.generalError = "",
        String? message})
      : super(message);
  @override
  List<Object?> get props =>
      [flowId, email, emailError, password, passwordError, generalError, message];
}

class AuthLoading extends AuthState {}