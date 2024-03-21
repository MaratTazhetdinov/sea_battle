// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_part.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

// coverage:ignore-start
/// @nodoc
extension $UserModelCopyWithExtension on UserModel {
  $UserModelCopyWith<UserModel> get copyWith =>
      $UserModelCopyWith<UserModel>(this, (value) => value);

  $UserModelCopyWithNull<UserModel> get copyWithNull =>
      $UserModelCopyWithNull<UserModel>(this, (value) => value);
}

/// @nodoc
class $UserModelCopyWith<$Return> {
  // ignore: unused_field
  final UserModel _value;

  // ignore: unused_field
  final $Return Function(UserModel) _callback;

  $UserModelCopyWith(this._value, this._callback);

  $Return call({
    String? id,
    String? email,
    String? nickname,
  }) =>
      _callback(UserModel(
        id: id ?? _value.id,
        email: email ?? _value.email,
        nickname: nickname ?? _value.nickname,
      ));
}

/// @nodoc
class $UserModelCopyWithNull<$Return> {
  // ignore: unused_field
  final UserModel _value;
  // ignore: unused_field
  final $Return Function(UserModel) _callback;

  $UserModelCopyWithNull(this._value, this._callback);
}

// coverage:ignore-end

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
    };

// **************************************************************************
// PropsGenerator
// **************************************************************************

// coverage:ignore-start
/// @nodoc
List<Object?> _$UserModelProps(UserModel instance,
        {List<Object?>? superProps}) =>
    [instance.id, instance.email, instance.nickname, ...?superProps];
// coverage:ignore-end
