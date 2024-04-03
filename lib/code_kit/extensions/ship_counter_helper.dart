part of '../code_kit_part.dart';

/// Extension on [ShipCounter].
extension ShipCounterHelper on ShipCounter {
  /// Removes specific [ShipType] from map and returns new [ShipCounter].
  ShipCounter removeShip(ShipType shipType) {
    final map = counterMap;
    map.update(shipType, (count) => count - 1);
    return copyWith(counterMap: map);
  }

  /// Adds specific [ShipType] to map and returns new [ShipCounter].
  ShipCounter addShip(ShipType shipType) {
    final map = counterMap;
    map.update(shipType, (count) => count + 1);
    return copyWith(counterMap: map);
  }
}
