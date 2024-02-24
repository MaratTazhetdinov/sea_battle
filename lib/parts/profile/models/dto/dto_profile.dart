part of '../../profile_part.dart';

@JsonSerializable()
class DtoProfile {
  final String id;
  final String email;
  final String nickname;

  const DtoProfile({
    required this.id,
    required this.email,
    required this.nickname,
  });

  factory DtoProfile.fromJson(Map<String, dynamic> json) =>
      _$DtoProfileFromJson(json);

  Map<String, dynamic> toJson() => _$DtoProfileToJson(this);
}
