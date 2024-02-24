part of '../user_part.dart';

/// [User]
@copyWith
@props
class UserModel extends Equatable {
  final String id;
  final String email;
  final String nickname;

  const UserModel({
    required this.id,
    required this.email,
    required this.nickname,
  });

  factory UserModel.fromFirebaseUser({required User firebaseUser}) {
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      nickname: '',
    );
  }

  factory UserModel.fromProfile({required Profile profile}) {
    return UserModel(
      id: profile.id,
      email: profile.email,
      nickname: profile.nickname,
    );
  }

  /// Empty user which represents an unauthenticated user.
  static const empty = UserModel(
    id: '',
    email: '',
    nickname: '',
  );

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object?> get props => _$UserModelProps(this);
}
