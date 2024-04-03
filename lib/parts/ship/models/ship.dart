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

  factory Ship.fromIndexes(List<int> indexes) {
    if (indexes.length == 1) {
      return const Ship(shipType: ShipType.one, shipAxis: Axis.horizontal);
    } else {
      return Ship(
        shipType: ShipType.values
            .firstWhere((shipType) => shipType.size == indexes.length),
        shipAxis:
            indexes[1] - indexes[0] == 1 ? Axis.horizontal : Axis.vertical,
      );
    }
  }

  /// Empty [Ship].
  const Ship.empty([
    this.shipType = ShipType.empty,
    this.shipAxis = Axis.horizontal,
  ]);
}
