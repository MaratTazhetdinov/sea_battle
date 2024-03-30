part of '../ships_alignment_part.dart';

@props
@copyWith
class Board extends Equatable {
  final BoardCell boardCell;

  const Board(this.boardCell);

  factory Board.factory([BoardCell? boardCell]) {
    return Board(boardCell ?? _createBoard(100));
  }

  static BoardCell _createBoard(int cellsNumber) {
    final List<BoardCell> cells =
        List.generate(cellsNumber, (index) => BoardCell(index: index));

    for (BoardCell cell in cells) {
      final index = cell.index;
      final copy = cells[index];
      copy.topCell = index - 10 >= 0 ? cells[index - 10] : null;
      copy.topRightCell =
          index - 10 >= 0 && index % 10 < 9 ? cells[index - 9] : null;
      copy.rightCell = index % 10 < 9 ? cells[index + 1] : null;
      copy.bottomRightCell = index + 10 <= cellsNumber - 1 && index % 10 < 9
          ? cells[index + 11]
          : null;
      copy.bottomCell =
          index + 10 <= cellsNumber - 1 ? cells[index + 10] : null;
      copy.bottomLeftCell = index + 10 <= cellsNumber - 1 && index % 10 > 0
          ? cells[index + 9]
          : null;
      copy.leftCell = index % 10 > 0 ? cells[index - 1] : null;
      copy.topLeftCell =
          index - 10 >= 0 && index % 10 > 0 ? cells[index - 11] : null;
    }
    return cells.first;
  }

  @override
  List<Object?> get props => _$BoardProps(this);
}
