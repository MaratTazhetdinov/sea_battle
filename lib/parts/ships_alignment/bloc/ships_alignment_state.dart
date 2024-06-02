part of '../ships_alignment_part.dart';

/// State for [ShipsAlignmentState].
@copyWith
@props
class ShipsAlignmentState extends Equatable {
  /// [GameBoard].
  final GameBoard gameBoard;

  /// [ShipCounter].
  final ShipCounter shipCounter;

  /// Flag for alignment completion.
  final bool isAlignmentComplited;

  /// Creates [ShipsAlignmentState].
  const ShipsAlignmentState({
    required this.gameBoard,
    required this.shipCounter,
    this.isAlignmentComplited = false,
  });

  @override
  List<Object?> get props => _$ShipsAlignmentStateProps(this);
}
