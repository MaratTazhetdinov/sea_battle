part of '../ship_part.dart';

/// [Ship].
class Ship {
  /// [ShipType].
  final ShipType shipType;

  /// Ship [Axis].
  final Axis shipAxis;

  /// Creates [Ship].
  const Ship({
    required this.shipType,
    required this.shipAxis,
  });

  /// Empty [Ship].
  const Ship.empty([
    this.shipType = ShipType.empty,
    this.shipAxis = Axis.horizontal,
  ]);
}
