part of '../ships_alignment_part.dart';

abstract class ShipAlignmentEvent {}

class ShipRemovedByIndex extends ShipAlignmentEvent {
  final int index;

  ShipRemovedByIndex(this.index);
}

class ShipAddedByIndexes extends ShipAlignmentEvent {
  final List<int> indexes;

  ShipAddedByIndexes(this.indexes);
}

class ShipAlignmentCompleted extends ShipAlignmentEvent {
  final String userId;
  final List<int> cells;

  ShipAlignmentCompleted({required this.userId, required this.cells});
}
