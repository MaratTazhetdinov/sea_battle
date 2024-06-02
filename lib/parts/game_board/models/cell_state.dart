part of '../game_board_part.dart';

/// [CellState].
enum CellState {
  empty(0),
  occupied(1),
  destroyed(2),
  shot(3);

  final int value;

  /// Creates [CellState].
  const CellState(this.value);
}
