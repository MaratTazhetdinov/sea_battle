part of '../auth_part.dart';

enum AuthStatus { authenticated, unauthenticated }

@copyWith
@props
class AuthState extends Equatable {
  final AuthStatus status;
  final UserModel user;

  const AuthState({
    required this.status,
    required this.user,
  });

  @override
  List<Object?> get props => _$AuthStateProps(this);
}

class AuthInitial extends AuthState {
  const AuthInitial()
      : super(status: AuthStatus.unauthenticated, user: UserModel.empty);
}

class AuthLoading extends AuthState {
  const AuthLoading({required super.status, required super.user});
}

class AuthError extends AuthState {
  final Object error;

  const AuthError({
    required this.error,
    required super.status,
    required super.user,
  });
}
