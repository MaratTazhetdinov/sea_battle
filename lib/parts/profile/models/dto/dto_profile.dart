part of '../../profile_part.dart';

@JsonSerializable()
class DtoProfile {
  final String id;
  final String email;
  final String nickname;
  final int win;
  final int loss;

  const DtoProfile({
    required this.id,
    required this.email,
    required this.nickname,
    required this.win,
    required this.loss,
  });

  factory DtoProfile.fromJson(Map<String, dynamic> json) =>
      _$DtoProfileFromJson(json);

  Map<String, dynamic> toJson() => _$DtoProfileToJson(this);
}
