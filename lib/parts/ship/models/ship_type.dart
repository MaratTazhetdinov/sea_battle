part of '../ship_part.dart';

/// [ShipType].
enum ShipType {
  empty(0),
  one(1),
  two(2),
  three(3),
  four(4);

  /// Number of cells ship occupies.
  final int size;

  /// Creates [ShipType].
  const ShipType(this.size);
}
