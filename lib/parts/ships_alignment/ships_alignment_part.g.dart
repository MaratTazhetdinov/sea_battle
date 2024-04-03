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
List<Object?> _$ShipCounterProps(ShipCounter instance,
        {List<Object?>? superProps}) =>
    [instance.counterMap, ...?superProps];
// coverage:ignore-end
