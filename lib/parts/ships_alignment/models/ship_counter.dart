part of '../ships_alignment_part.dart';

@props
@copyWith
class ShipCounter extends Equatable {
  final Map<ShipType, int> counterMap;

  const ShipCounter(this.counterMap);

  factory ShipCounter.factory([Map<ShipType, int>? counterMap]) {
    return ShipCounter(counterMap ??
        {
          ShipType.four: 1,
          ShipType.three: 2,
          ShipType.two: 3,
          ShipType.one: 4,
        });
  }

  bool get isEmpty => counterMap.values.every((count) => count == 0);

  @override
  List<Object?> get props => _$ShipCounterProps(this);
}
