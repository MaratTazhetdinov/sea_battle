// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_board_part.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

// coverage:ignore-start
/// @nodoc
extension $GameBoardCopyWithExtension on GameBoard {
  $GameBoardCopyWith<GameBoard> get copyWith =>
      $GameBoardCopyWith<GameBoard>(this, (value) => value);

  $GameBoardCopyWithNull<GameBoard> get copyWithNull =>
      $GameBoardCopyWithNull<GameBoard>(this, (value) => value);
}

/// @nodoc
class $GameBoardCopyWith<$Return> {
  // ignore: unused_field
  final GameBoard _value;

  // ignore: unused_field
  final $Return Function(GameBoard) _callback;

  $GameBoardCopyWith(this._value, this._callback);

  $Return call({
    String? userId,
    GameBoardCell? gameBoardCell,
  }) =>
      _callback(GameBoard(
        userId: userId ?? _value.userId,
        gameBoardCell: gameBoardCell ?? _value.gameBoardCell,
      ));
}

/// @nodoc
class $GameBoardCopyWithNull<$Return> {
  // ignore: unused_field
  final GameBoard _value;
  // ignore: unused_field
  final $Return Function(GameBoard) _callback;

  $GameBoardCopyWithNull(this._value, this._callback);
}

// coverage:ignore-end

// **************************************************************************
// PropsGenerator
// **************************************************************************

// coverage:ignore-start
/// @nodoc
List<Object?> _$GameBoardProps(GameBoard instance,
        {List<Object?>? superProps}) =>
    [instance.userId, instance.gameBoardCell, ...?superProps];
// coverage:ignore-end
