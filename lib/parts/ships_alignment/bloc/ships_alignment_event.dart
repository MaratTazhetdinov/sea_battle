part of '../ships_alignment_part.dart';

abstract class ShipsAlignmentEvent {}

/// Removes ship by [index] from [Board].
class ShipRemovedByIndex extends ShipsAlignmentEvent {
  final int index;

  ShipRemovedByIndex(this.index);
}

/// Adds ship by list of indexes to [Board].
class ShipAddedByIndexes extends ShipsAlignmentEvent {
  final List<int> indexes;

  ShipAddedByIndexes(this.indexes);
}

/// Sends result of completed ships data to backend.
class ShipsAlignmentCompleted extends ShipsAlignmentEvent {
  final String userId;
  final List<int> cells;

  ShipsAlignmentCompleted({required this.userId, required this.cells});
}
