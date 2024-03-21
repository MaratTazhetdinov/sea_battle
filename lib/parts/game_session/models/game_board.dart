part of '../game_session_part.dart';

enum CellState {
  empty(0),
  occupied(1),
  destroyed(2),
  shooted(3);

  final int value;

  const CellState(this.value);
}

class GameBoard {
  final String userId;
  final List<CellState> cells;

  const GameBoard({
    required this.userId,
    required this.cells,
  });

  factory GameBoard.fromDto(DtoGameBoard dtoGameBoard) => GameBoard(
        userId: dtoGameBoard.userId,
        cells: dtoGameBoard.cells
            .map((cellState) => switch (cellState) {
                  1 => CellState.occupied,
                  2 => CellState.destroyed,
                  3 => CellState.shooted,
                  _ => CellState.empty,
                })
            .toList(),
      );
}
