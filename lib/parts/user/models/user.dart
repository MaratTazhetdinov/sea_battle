part of '../user_part.dart';

/// [User]
class UserModel extends Equatable {
  final String id;
  final String? email;
  final String? name;

  const UserModel({
    required this.id,
    this.email,
    this.name,
  });

  factory UserModel.fromFirebaseUser({required User firebaseUser}) {
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      name: firebaseUser.displayName,
    );
  }

  /// Empty user which represents an unauthenticated user.
  static const empty = UserModel(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object?> get props => [
        id,
        email,
        name,
      ];
}
