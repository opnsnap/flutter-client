part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartApp extends AuthEvent {} //app is started

class InitLoginFlow extends AuthEvent {} //initialize login flow

class InitRegistrationFlow extends AuthEvent {} //initialize registration flow

class SignIn extends AuthEvent {
  final String flowId;
  final String email;
  final String password;

  SignIn(this.flowId, this.email, this.password);
  @override
  List<Object?> get props => [flowId, email, password];
}

class SignUp extends AuthEvent {
  final String flowId;
  final String email;
  final String password;

  SignUp(this.flowId, this.email, this.password);
  @override
  List<Object?> get props => [flowId, email, password];
}

class ChangeField extends AuthEvent { //change email/password fields in sign in/sign up form
  final String value;
  final String field;

  ChangeField(this.value, this.field);
}

class SignOut extends AuthEvent{}