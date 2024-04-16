part of '../game_logic_part.dart';

class GameLogic extends IGameLogic {
  final GameBoard userBoard;
  final GameBoard enemyBoard;

  GameLogic({
    required this.userBoard,
    required this.enemyBoard,
  });

  factory GameLogic.fromGameSession(GameSession gameSession, String userId) {
    final userBoard = gameSession.gameBoards
        .firstWhere((gameBoard) => gameBoard.userId == userId);
    final enemyBoard = gameSession.gameBoards
        .firstWhere((gameBoard) => gameBoard.userId != userId);
    return GameLogic(
      userBoard: userBoard,
      enemyBoard: enemyBoard,
    );
  }

  int? shoot(int cellIndex) =>
      switch (enemyBoard.cell.goToCellWithIndex(cellIndex).cellState) {
        CellState.empty => CellState.shot.value,
        CellState.occupied => CellState.destroyed.value,
        _ => null,
      };
}
