part of '../profile_part.dart';

class Profile {
  final String id;
  final String email;
  final String nickname;
  final int win;
  final int loss;

  const Profile({
    required this.id,
    required this.email,
    required this.nickname,
    required this.loss,
    required this.win,
  });

  factory Profile.fromDto(DtoProfile dtoProfile) {
    return Profile(
      id: dtoProfile.id,
      email: dtoProfile.email,
      nickname: dtoProfile.nickname,
      win: dtoProfile.win,
      loss: dtoProfile.loss,
    );
  }

  DtoProfile toDto() => DtoProfile(
        id: id,
        email: email,
        nickname: nickname,
        win: win,
        loss: loss,
      );
}
