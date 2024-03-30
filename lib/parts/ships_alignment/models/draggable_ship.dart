part of '../ships_alignment_part.dart';

@props
@copyWith
class DraggableShip extends Equatable {
  final Ship ship;
  final Offset offset;

  const DraggableShip({required this.ship, required this.offset});

  const DraggableShip.empty(
      {this.ship = const Ship.empty(), this.offset = Offset.zero});

  @override
  List<Object?> get props => _$DraggableShipProps(this);
}
