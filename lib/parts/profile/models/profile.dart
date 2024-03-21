part of '../profile_part.dart';

class Profile {
  final String id;
  final String email;
  final String nickname;

  const Profile({
    required this.id,
    required this.email,
    required this.nickname,
  });

  factory Profile.fromDto(DtoProfile dtoProfile) {
    return Profile(
      id: dtoProfile.id,
      email: dtoProfile.email,
      nickname: dtoProfile.nickname,
    );
  }

  DtoProfile toDto() => DtoProfile(
        id: id,
        email: email,
        nickname: nickname,
      );
}
