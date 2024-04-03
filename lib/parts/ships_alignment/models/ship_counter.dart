part of '../ships_alignment_part.dart';

@props
@copyWith

/// [ShipCounter].
class ShipCounter extends Equatable {
  /// Map which contains ships count for specific [ShipType].
  final Map<ShipType, int> counterMap;

  /// Creates [ShipCounter].
  const ShipCounter(this.counterMap);

  /// Factory constructor for creating [ShipCounter].
  factory ShipCounter.create() {
    final map = {
      ShipType.four: 1,
      ShipType.three: 2,
      ShipType.two: 3,
      ShipType.one: 4,
    };
    return ShipCounter(map);
  }

  /// Getter which checks whether count of all [ShipType] is zero or not.
  bool get isEmpty => counterMap.values.every((count) => count == 0);

  @override
  List<Object?> get props => _$ShipCounterProps(this);
}
