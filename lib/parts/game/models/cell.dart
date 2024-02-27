part of '../game_part.dart';

enum CellState {
  empty(0),
  occupuied(1),
  destroyed(2);

  final int value;

  const CellState(this.value);
}

class Cell {
  final CellState state;

  const Cell({required this.state});
}
