part of '../ships_alignment_part.dart';

abstract class ShipsAlignmentEvent {}

/// Removes ship by list of [indexes] from [Board].
class ShipRemovedByIndexes extends ShipsAlignmentEvent {
  final List<int> indexes;

  ShipRemovedByIndexes(this.indexes);
}

/// Adds ship by list of indexes to [Board].
class ShipAddedByIndexes extends ShipsAlignmentEvent {
  final List<int> indexes;

  ShipAddedByIndexes(this.indexes);
}

/// Sends result of completed ships data to backend.
class ShipsAlignmentCompleted extends ShipsAlignmentEvent {
  final String gameSessionId;

  ShipsAlignmentCompleted({required this.gameSessionId});
}
