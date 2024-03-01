part of '../game_session_part.dart';

class GameBoard {
  final String userId;
  final String userNickname;
  final List<Cell> cells;

  const GameBoard({
    required this.userId,
    required this.userNickname,
    required this.cells,
  });

  static const empty = GameBoard(
    userId: '',
    userNickname: '',
    cells: [],
  );

  factory GameBoard.fromDto(DtoGameBoard? dtoGameBoard) => GameBoard(
        userId: dtoGameBoard?.userId ?? '',
        userNickname: dtoGameBoard?.userNickname ?? '',
        cells: [],
      );
}
