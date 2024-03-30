part of '../ships_alignment_part.dart';

class Ship {
  final ShipType shipType;
  final Axis shipAxis;

  const Ship({required this.shipType, required this.shipAxis});

  const Ship.empty(
      [this.shipType = ShipType.one, this.shipAxis = Axis.horizontal]);
}
