part of '../code_kit_part.dart';

extension ShipCounterHelper on ShipCounter {
  ShipCounter removeShip(ShipType shipType) {
    final map = counterMap;
    map.update(shipType, (count) => count - 1);
    return copyWith(counterMap: map);
  }

  ShipCounter addShip(ShipType shipType) {
    final map = counterMap;
    map.update(shipType, (count) => count + 1);
    return copyWith(counterMap: map);
  }
}
