part of '../game_session_part.dart';

class GameBoard {
  final String userId;
  final List<Cell> cells;

  const GameBoard({
    required this.userId,
    required this.cells,
  });

  static const empty = GameBoard(
    userId: '',
    cells: [],
  );

  factory GameBoard.fromDto(DtoGameBoard? dtoGameBoard) => GameBoard(
        userId: dtoGameBoard?.userId ?? '',
        cells: [],
      );
}
