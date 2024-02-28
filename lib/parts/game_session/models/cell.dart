part of '../game_session_part.dart';

enum CellState {
  empty(0),
  shooted(1),
  occupuied(2),
  destroyed(3);

  final int value;

  const CellState(this.value);
}

class Cell {
  final CellState state;

  const Cell({required this.state});

  factory Cell.fromDto({required DtoCell dtoCell}) => Cell(
          state: switch (dtoCell.state) {
        1 => CellState.shooted,
        2 => CellState.occupuied,
        3 => CellState.destroyed,
        _ => CellState.empty,
      });

  DtoCell toDto() => DtoCell(state: state.value);
}
