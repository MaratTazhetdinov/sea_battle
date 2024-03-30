part of '../ships_alignment_part.dart';

@props
@copyWith
class ShipAlignmentState extends Equatable {
  final Board board;
  final ShipCounter shipCounter;

  const ShipAlignmentState({
    required this.board,
    required this.shipCounter,
  });

  @override
  List<Object?> get props => _$ShipAlignmentStateProps(this);
}
