part of '../code_kit_part.dart';

extension ShipCounterHelper on ShipCounter {
  Map<ShipType, int> removeShip(ShipType shipType) {
    final map = counterMap;
    map.update(shipType, (count) => count - 1);
    return map;
  }

  Map<ShipType, int> addShip(ShipType shipType) {
    final map = counterMap;
    map.update(shipType, (count) => count + 1);
    return map;
  }
}
