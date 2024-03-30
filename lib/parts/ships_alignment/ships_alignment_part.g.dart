// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ships_alignment_part.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

// coverage:ignore-start
/// @nodoc
extension $BoardCopyWithExtension on Board {
  $BoardCopyWith<Board> get copyWith =>
      $BoardCopyWith<Board>(this, (value) => value);

  $BoardCopyWithNull<Board> get copyWithNull =>
      $BoardCopyWithNull<Board>(this, (value) => value);
}

/// @nodoc
class $BoardCopyWith<$Return> {
  // ignore: unused_field
  final Board _value;

  // ignore: unused_field
  final $Return Function(Board) _callback;

  $BoardCopyWith(this._value, this._callback);

  $Return call({
    BoardCell? boardCell,
  }) =>
      _callback(Board(
        boardCell ?? _value.boardCell,
      ));
}

/// @nodoc
class $BoardCopyWithNull<$Return> {
  // ignore: unused_field
  final Board _value;
  // ignore: unused_field
  final $Return Function(Board) _callback;

  $BoardCopyWithNull(this._value, this._callback);
}

// coverage:ignore-end

// coverage:ignore-start
/// @nodoc
extension $DraggableShipCopyWithExtension on DraggableShip {
  $DraggableShipCopyWith<DraggableShip> get copyWith =>
      $DraggableShipCopyWith<DraggableShip>(this, (value) => value);

  $DraggableShipCopyWithNull<DraggableShip> get copyWithNull =>
      $DraggableShipCopyWithNull<DraggableShip>(this, (value) => value);
}

/// @nodoc
class $DraggableShipCopyWith<$Return> {
  // ignore: unused_field
  final DraggableShip _value;

  // ignore: unused_field
  final $Return Function(DraggableShip) _callback;

  $DraggableShipCopyWith(this._value, this._callback);

  $Return call({
    Ship? ship,
    Offset? offset,
  }) =>
      _callback(DraggableShip(
        ship: ship ?? _value.ship,
        offset: offset ?? _value.offset,
      ));
}

/// @nodoc
class $DraggableShipCopyWithNull<$Return> {
  // ignore: unused_field
  final DraggableShip _value;
  // ignore: unused_field
  final $Return Function(DraggableShip) _callback;

  $DraggableShipCopyWithNull(this._value, this._callback);
}

// coverage:ignore-end

// coverage:ignore-start
/// @nodoc
extension $ShipAlignmentStateCopyWithExtension on ShipAlignmentState {
  $ShipAlignmentStateCopyWith<ShipAlignmentState> get copyWith =>
      $ShipAlignmentStateCopyWith<ShipAlignmentState>(this, (value) => value);

  $ShipAlignmentStateCopyWithNull<ShipAlignmentState> get copyWithNull =>
      $ShipAlignmentStateCopyWithNull<ShipAlignmentState>(
          this, (value) => value);
}

/// @nodoc
class $ShipAlignmentStateCopyWith<$Return> {
  // ignore: unused_field
  final ShipAlignmentState _value;

  // ignore: unused_field
  final $Return Function(ShipAlignmentState) _callback;

  $ShipAlignmentStateCopyWith(this._value, this._callback);

  $BoardCopyWith<$Return> get board => $BoardCopyWith<$Return>(
      _value.board, (value) => _callback(_value.copyWith(board: value)));

  $ShipCounterCopyWith<$Return> get shipCounter =>
      $ShipCounterCopyWith<$Return>(_value.shipCounter,
          (value) => _callback(_value.copyWith(shipCounter: value)));

  $Return call({
    Board? board,
    ShipCounter? shipCounter,
  }) =>
      _callback(ShipAlignmentState(
        board: board ?? _value.board,
        shipCounter: shipCounter ?? _value.shipCounter,
      ));
}

/// @nodoc
class $ShipAlignmentStateCopyWithNull<$Return> {
  // ignore: unused_field
  final ShipAlignmentState _value;
  // ignore: unused_field
  final $Return Function(ShipAlignmentState) _callback;

  $ShipAlignmentStateCopyWithNull(this._value, this._callback);

  $BoardCopyWithNull<$Return> get board => $BoardCopyWithNull<$Return>(
      _value.board, (value) => _callback(_value.copyWith(board: value)));

  $ShipCounterCopyWithNull<$Return> get shipCounter =>
      $ShipCounterCopyWithNull<$Return>(_value.shipCounter,
          (value) => _callback(_value.copyWith(shipCounter: value)));
}

// coverage:ignore-end

// coverage:ignore-start
/// @nodoc
extension $ShipCounterCopyWithExtension on ShipCounter {
  $ShipCounterCopyWith<ShipCounter> get copyWith =>
      $ShipCounterCopyWith<ShipCounter>(this, (value) => value);

  $ShipCounterCopyWithNull<ShipCounter> get copyWithNull =>
      $ShipCounterCopyWithNull<ShipCounter>(this, (value) => value);
}

/// @nodoc
class $ShipCounterCopyWith<$Return> {
  // ignore: unused_field
  final ShipCounter _value;

  // ignore: unused_field
  final $Return Function(ShipCounter) _callback;

  $ShipCounterCopyWith(this._value, this._callback);

  $Return call({
    Map<ShipType, int>? counterMap,
  }) =>
      _callback(ShipCounter(
        counterMap ?? _value.counterMap,
      ));
}

/// @nodoc
class $ShipCounterCopyWithNull<$Return> {
  // ignore: unused_field
  final ShipCounter _value;
  // ignore: unused_field
  final $Return Function(ShipCounter) _callback;

  $ShipCounterCopyWithNull(this._value, this._callback);
}

// coverage:ignore-end

// **************************************************************************
// PropsGenerator
// **************************************************************************

// coverage:ignore-start
/// @nodoc
List<Object?> _$BoardProps(Board instance, {List<Object?>? superProps}) =>
    [instance.boardCell, ...?superProps];
// coverage:ignore-end

// coverage:ignore-start
/// @nodoc
List<Object?> _$DraggableShipProps(DraggableShip instance,
        {List<Object?>? superProps}) =>
    [instance.ship, instance.offset, ...?superProps];
// coverage:ignore-end

// coverage:ignore-start
/// @nodoc
List<Object?> _$ShipAlignmentStateProps(ShipAlignmentState instance,
        {List<Object?>? superProps}) =>
    [instance.board, instance.shipCounter, ...?superProps];
// coverage:ignore-end

// coverage:ignore-start
/// @nodoc
List<Object?> _$ShipCounterProps(ShipCounter instance,
        {List<Object?>? superProps}) =>
    [instance.counterMap, ...?superProps];
// coverage:ignore-end
