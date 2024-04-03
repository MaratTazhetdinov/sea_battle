part of '../ships_alignment_part.dart';

@props
@copyWith

/// State for [ShipsAlignmentState].
class ShipsAlignmentState extends Equatable {
  /// [GameBoard].
  final GameBoard board;

  /// [ShipCounter].
  final ShipCounter shipCounter;

  /// Creates [ShipsAlignmentState].
  const ShipsAlignmentState({
    required this.board,
    required this.shipCounter,
  });

  @override
  List<Object?> get props => _$ShipsAlignmentStateProps(this);
}
