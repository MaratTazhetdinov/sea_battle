part of '../auth_part.dart';

abstract class AuthEvent {}

class AuthSignedUpByEmailAndPassword extends AuthEvent {
  final String email;
  final String password;

  AuthSignedUpByEmailAndPassword({
    required this.email,
    required this.password,
  });
}

class AuthSignedInByEmailAndPassword extends AuthEvent {
  final String email;
  final String password;

  AuthSignedInByEmailAndPassword({
    required this.email,
    required this.password,
  });
}

class _AuthUserChanged extends AuthEvent {
  final UserModel user;

  _AuthUserChanged({required this.user});
}

class AuthLoggedOut extends AuthEvent {}
