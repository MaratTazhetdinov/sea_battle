part of '../ships_alignment_part.dart';

/// State for [ShipsAlignmentState].
class ShipsAlignmentState {
  /// [GameBoard].
  final GameBoard gameBoard;

  /// [ShipCounter].
  final ShipCounter shipCounter;

  /// Creates [ShipsAlignmentState].
  const ShipsAlignmentState({
    required this.gameBoard,
    required this.shipCounter,
  });
}
