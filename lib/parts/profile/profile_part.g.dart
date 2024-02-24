// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DtoProfile _$DtoProfileFromJson(Map<String, dynamic> json) => DtoProfile(
      id: json['id'] as String,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$DtoProfileToJson(DtoProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
    };
