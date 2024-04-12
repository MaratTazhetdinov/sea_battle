part of '../game_logic_part.dart';

class GameLogic extends IGameLogic {
  final GameBoard userBoard;
  final GameBoard enemyBoard;

  GameLogic({
    required this.userBoard,
    required this.enemyBoard,
  });

  int? shoot(int cellIndex) =>
      switch (enemyBoard.cell.goToCellWithIndex(cellIndex).cellState) {
        CellState.empty => CellState.shooted.value,
        CellState.occupied => CellState.destroyed.value,
        _ => null,
      };
}
