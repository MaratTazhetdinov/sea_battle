// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ships_alignment_part.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

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
extension $ShipsAlignmentStateCopyWithExtension on ShipsAlignmentState {
  $ShipsAlignmentStateCopyWith<ShipsAlignmentState> get copyWith =>
      $ShipsAlignmentStateCopyWith<ShipsAlignmentState>(this, (value) => value);

  $ShipsAlignmentStateCopyWithNull<ShipsAlignmentState> get copyWithNull =>
      $ShipsAlignmentStateCopyWithNull<ShipsAlignmentState>(
          this, (value) => value);
}

/// @nodoc
class $ShipsAlignmentStateCopyWith<$Return> {
  // ignore: unused_field
  final ShipsAlignmentState _value;

  // ignore: unused_field
  final $Return Function(ShipsAlignmentState) _callback;

  $ShipsAlignmentStateCopyWith(this._value, this._callback);

  $GameBoardCopyWith<$Return> get board => $GameBoardCopyWith<$Return>(
      _value.board, (value) => _callback(_value.copyWith(board: value)));

  $ShipCounterCopyWith<$Return> get shipCounter =>
      $ShipCounterCopyWith<$Return>(_value.shipCounter,
          (value) => _callback(_value.copyWith(shipCounter: value)));

  $Return call({
    GameBoard? board,
    ShipCounter? shipCounter,
  }) =>
      _callback(ShipsAlignmentState(
        board: board ?? _value.board,
        shipCounter: shipCounter ?? _value.shipCounter,
      ));
}

/// @nodoc
class $ShipsAlignmentStateCopyWithNull<$Return> {
  // ignore: unused_field
  final ShipsAlignmentState _value;
  // ignore: unused_field
  final $Return Function(ShipsAlignmentState) _callback;

  $ShipsAlignmentStateCopyWithNull(this._value, this._callback);

  $GameBoardCopyWithNull<$Return> get board => $GameBoardCopyWithNull<$Return>(
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
List<Object?> _$DraggableShipProps(DraggableShip instance,
        {List<Object?>? superProps}) =>
    [instance.ship, instance.offset, ...?superProps];
// coverage:ignore-end

// coverage:ignore-start
/// @nodoc
List<Object?> _$ShipsAlignmentStateProps(ShipsAlignmentState instance,
        {List<Object?>? superProps}) =>
    [instance.board, instance.shipCounter, ...?superProps];
// coverage:ignore-end

// coverage:ignore-start
/// @nodoc
List<Object?> _$ShipCounterProps(ShipCounter instance,
        {List<Object?>? superProps}) =>
    [instance.counterMap, ...?superProps];
// coverage:ignore-end
