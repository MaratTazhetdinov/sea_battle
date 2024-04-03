part of '../ships_alignment_part.dart';

@props
@copyWith

/// [DraggableShip].
class DraggableShip extends Equatable {
  /// [Ship].
  final Ship ship;

  /// Global [Offset].
  final Offset offset;

  /// Creates [DraggableShip].
  const DraggableShip({
    required this.ship,
    required this.offset,
  });

  /// Empty [DraggableShip].
  const DraggableShip.empty({
    this.ship = const Ship.empty(),
    this.offset = Offset.zero,
  });

  @override
  List<Object?> get props => _$DraggableShipProps(this);
}
