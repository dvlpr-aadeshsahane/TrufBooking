import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  AuthLoginRequested(this.email, this.password);

  @override
  // TODO: implement props
  List<Object> get props => [email, password];
}

class AuthSignupRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  AuthSignupRequested(this.email, this.password, this.name);
  @override
  // TODO: implement props
  List<Object> get props => [name, email, password];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthUserChanged extends AuthEvent {
  final Object? user;
  AuthUserChanged(this.user);
}
