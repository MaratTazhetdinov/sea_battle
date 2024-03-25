part of '../ships_alignment_part.dart';

class Board {
  final int cellsNumber;
  BoardCell boardCell;
  List<int> occupiedIndexes = [];

  Board({required this.cellsNumber}) : boardCell = _createBoard(cellsNumber);

  void alignShip() {}

  static BoardCell _createBoard(int cellsNumber) {
    final List<BoardCell> cells =
        List.generate(cellsNumber, (index) => BoardCell(index: index));

    for (BoardCell cell in cells) {
      final index = cell.index;
      final copy = cells[index];
      if (index == 79 || index == 84 || index == 99) {
        copy.isOccupied = true;
      }
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

  List<int> _findOccupiedIndexes() {
    final List<int> res = [];

    BoardCell? head = boardCell;

    while (head != null) {
      if (head.isOccupied) {
        res.add(head.index);
      }

      BoardCell? rightCell = head.rightCell;
      BoardCell? bottomCell = head.bottomCell;
      while (rightCell != null && bottomCell != null) {
        if (rightCell.isOccupied) {
          res.add(rightCell.index);
        }
        if (bottomCell.isOccupied) {
          res.add(bottomCell.index);
        }
        rightCell = rightCell.rightCell;
        bottomCell = bottomCell.bottomCell;
      }

      head = head.bottomRightCell;
    }

    return res;
  }
}
