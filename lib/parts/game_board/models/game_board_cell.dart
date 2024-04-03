part of '../game_board_part.dart';

/// [CellState].
enum CellState {
  empty(0),
  occupied(1),
  destroyed(2),
  shooted(3);

  final int value;

  /// Creates [CellState].
  const CellState(this.value);
}

/// [GameBoard].
class GameBoardCell {
  /// Index on [GameBoard].
  final int index;

  /// [CellState].
  CellState cellState;

  /// Top [GameBoardCell].
  GameBoardCell? topCell;

  /// Top right [GameBoardCell].
  GameBoardCell? topRightCell;

  /// Right [GameBoardCell].
  GameBoardCell? rightCell;

  /// Bottom right [GameBoardCell].
  GameBoardCell? bottomRightCell;

  /// Bottom [GameBoardCell].
  GameBoardCell? bottomCell;

  /// Bottom left [GameBoardCell].
  GameBoardCell? bottomLeftCell;

  /// Left [GameBoardCell].
  GameBoardCell? leftCell;

  /// Top left [GameBoardCell].
  GameBoardCell? topLeftCell;

  /// Getter for checking whether [GameBoardCell] is occupied by ship or not.
  bool get isOccupied => cellState == CellState.occupied;

  /// Setter for changing [CellState].
  set setCellState(CellState state) => cellState = state;

  /// Creates [GameBoardCell].
  GameBoardCell({
    required this.index,
    required this.cellState,
    this.topCell,
    this.topRightCell,
    this.rightCell,
    this.bottomRightCell,
    this.bottomCell,
    this.bottomLeftCell,
    this.leftCell,
    this.topLeftCell,
  });
}
