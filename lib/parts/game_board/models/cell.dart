part of '../game_board_part.dart';

/// [Cell].
class Cell {
  /// Index on [Cell].
  final int index;

  /// [CellState].
  CellState cellState;

  /// Top [Cell].
  Cell? topCell;

  /// Top right [Cell].
  Cell? topRightCell;

  /// Right [Cell].
  Cell? rightCell;

  /// Bottom right [Cell].
  Cell? bottomRightCell;

  /// Bottom [Cell].
  Cell? bottomCell;

  /// Bottom left [Cell].
  Cell? bottomLeftCell;

  /// Left [Cell].
  Cell? leftCell;

  /// Top left [GameBoardCell].
  Cell? topLeftCell;

  /// Getter for checking whether [GameBoardCell] is occupied by ship or not.
  bool get isOccupied => cellState == CellState.occupied;

  /// Setter for changing [CellState].
  set setCellState(CellState state) => cellState = state;

  /// Creates [Cell].
  Cell({
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
