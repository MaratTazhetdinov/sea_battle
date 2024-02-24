// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_part.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

// coverage:ignore-start
/// @nodoc
extension $AuthStateCopyWithExtension on AuthState {
  $AuthStateCopyWith<AuthState> get copyWith =>
      $AuthStateCopyWith<AuthState>(this, (value) => value);

  $AuthStateCopyWithNull<AuthState> get copyWithNull =>
      $AuthStateCopyWithNull<AuthState>(this, (value) => value);
}

/// @nodoc
class $AuthStateCopyWith<$Return> {
  // ignore: unused_field
  final AuthState _value;

  // ignore: unused_field
  final $Return Function(AuthState) _callback;

  $AuthStateCopyWith(this._value, this._callback);

  $UserModelCopyWith<$Return> get user => $UserModelCopyWith<$Return>(
      _value.user, (value) => _callback(_value.copyWith(user: value)));

  $Return call({
    AuthStatus? status,
    UserModel? user,
  }) =>
      _callback(AuthState(
        status: status ?? _value.status,
        user: user ?? _value.user,
      ));
}

/// @nodoc
class $AuthStateCopyWithNull<$Return> {
  // ignore: unused_field
  final AuthState _value;
  // ignore: unused_field
  final $Return Function(AuthState) _callback;

  $AuthStateCopyWithNull(this._value, this._callback);

  $UserModelCopyWithNull<$Return> get user => $UserModelCopyWithNull<$Return>(
      _value.user, (value) => _callback(_value.copyWith(user: value)));
}

// coverage:ignore-end

// **************************************************************************
// PropsGenerator
// **************************************************************************

// coverage:ignore-start
/// @nodoc
List<Object?> _$AuthStateProps(AuthState instance,
        {List<Object?>? superProps}) =>
    [instance.status, instance.user, ...?superProps];
// coverage:ignore-end
