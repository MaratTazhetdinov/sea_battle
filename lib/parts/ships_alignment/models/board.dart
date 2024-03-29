part of '../ships_alignment_part.dart';

class Board {
  final int cellsNumber;
  BoardCell boardCell;

  Board({
    required this.cellsNumber,
  }) : boardCell = _createBoard(cellsNumber);

  List<int> get occupiedIndexes => _findOccupiedIndexes();

  List<int> checkShipAlignment({required int index, required Ship ship}) {
    _goToCellWithIndex(index);
    final List<int> result = [];
    BoardCell? cell = boardCell;
    int shipSize = ship.shipType.size;

    while (shipSize != 0 && cell != null) {
      if (!(cell.topCell?.isOccupied ?? false) &&
          !(cell.topRightCell?.isOccupied ?? false) &&
          !(cell.rightCell?.isOccupied ?? false) &&
          !(cell.bottomRightCell?.isOccupied ?? false) &&
          !(cell.bottomCell?.isOccupied ?? false) &&
          !(cell.bottomLeftCell?.isOccupied ?? false) &&
          !(cell.leftCell?.isOccupied ?? false) &&
          !(cell.topLeftCell?.isOccupied ?? false)) {
        result.add(cell.index);
      }
      if (ship.shipAxis == Axis.horizontal) {
        cell = cell.rightCell;
      } else {
        cell = cell.bottomCell;
      }

      shipSize--;
    }

    return result.length == ship.shipType.size ? result : [];
  }

  void addShipToBoard(List<int> indexes, Ship ship) {
    for (int i = 0; i < indexes.length; i++) {
      _goToCellWithIndex(indexes[i]);
      boardCell.isOccupied = true;
    }
  }

  void removeShipByIndex(int index) {
    final indexes = detectShipIndexesByIndex(index);
    for (int i = 0; i < indexes.length; i++) {
      _goToCellWithIndex(indexes[i]);
      boardCell.isOccupied = false;
    }
  }

  List<int> detectShipIndexesByIndex(int index) {
    final List<int> indexes = [index];

    _goToCellWithIndex(index);

    BoardCell? leftCell = boardCell.leftCell;
    BoardCell? rightCell = boardCell.rightCell;
    while (rightCell != null || leftCell != null) {
      if (rightCell != null) {
        indexes.add(rightCell.index);
        rightCell = rightCell.rightCell;
      }
      if (leftCell != null) {
        indexes.add(leftCell.index);
        leftCell = leftCell.leftCell;
      }
    }

    BoardCell? topCell = boardCell.topCell;
    BoardCell? bottomCell = boardCell.bottomCell;

    while (topCell != null || bottomCell != null) {
      if (topCell != null) {
        indexes.add(topCell.index);
        topCell = topCell.topCell;
      }
      if (bottomCell != null) {
        indexes.add(bottomCell.index);
        bottomCell = bottomCell.bottomCell;
      }
    }

    return indexes;
  }

  Ship detectShipByIndex(int index) {
    int shipSize = 1;
    _goToCellWithIndex(index);
    BoardCell? leftCell = boardCell.leftCell;
    BoardCell? rightCell = boardCell.rightCell;
    BoardCell? topCell = boardCell.topCell;
    BoardCell? bottomCell = boardCell.bottomCell;

    while (rightCell != null || leftCell != null) {
      if (rightCell != null) {
        if (rightCell.isOccupied) {
          shipSize++;
        }
        rightCell = rightCell.rightCell;
      }
      if (leftCell != null) {
        if (leftCell.isOccupied) {
          shipSize++;
        }
        leftCell = leftCell.leftCell;
      }
    }

    if (shipSize > 1) {
      return Ship(
        shipAxis: Axis.horizontal,
        shipType:
            ShipType.values.firstWhere((shipType) => shipType.size == shipSize),
      );
    }

    while (topCell != null || bottomCell != null) {
      if (topCell != null) {
        if (topCell.isOccupied) {
          shipSize++;
        }
        topCell = topCell.topCell;
      }
      if (bottomCell != null) {
        if (bottomCell.isOccupied) {
          shipSize++;
        }
        bottomCell = bottomCell.bottomCell;
      }
    }

    return Ship(
      shipAxis: Axis.vertical,
      shipType:
          ShipType.values.firstWhere((shipType) => shipType.size == shipSize),
    );
  }

  bool isOccupiedIndex(int index) {
    _goToCellWithIndex(index);
    return boardCell.isOccupied;
  }

  void _goToCellWithIndex(int index) {
    final currentIndex = boardCell.index;

    int horizontalDiff = (currentIndex % 10) - (index % 10);

    if (horizontalDiff < 0) {
      while (horizontalDiff != 0) {
        if (boardCell.rightCell case final cell?) {
          boardCell = cell;
        }
        horizontalDiff++;
      }
    } else if (horizontalDiff > 0) {
      while (horizontalDiff != 0) {
        if (boardCell.leftCell case final cell?) {
          boardCell = cell;
        }
        horizontalDiff--;
      }
    }

    int verticalDiff =
        (currentIndex - (currentIndex % 10)) - (index - (index % 10));

    if (verticalDiff < 0) {
      while (verticalDiff != 0) {
        if (boardCell.bottomCell case final cell?) {
          boardCell = cell;
        }
        verticalDiff += 10;
      }
    } else if (verticalDiff > 0) {
      while (verticalDiff != 0) {
        if (boardCell.topCell case final cell?) {
          boardCell = cell;
        }
        verticalDiff -= 10;
      }
    }
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

  List<int> _findOccupiedIndexes() {
    final List<int> res = [];

    _goToCellWithIndex(0);

    BoardCell? cell = boardCell;

    while (cell != null) {
      if (cell.isOccupied) {
        res.add(cell.index);
      }

      BoardCell? rightCell = cell.rightCell;
      BoardCell? bottomCell = cell.bottomCell;
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

      cell = cell.bottomRightCell;
    }

    return res;
  }
}
