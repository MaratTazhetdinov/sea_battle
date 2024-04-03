part of '../code_kit_part.dart';

extension BoardHelper on GameBoard {
  List<int> checkPossibleAlignment({required int index, required Ship ship}) {
    GameBoardCell? boardCell = _goToCellWithIndex(index, gameBoardCell);
    final List<int> result = [];
    int shipSize = ship.shipType.size;

    while (shipSize != 0 && boardCell != null) {
      if (!(boardCell.topCell?.isOccupied ?? false) &&
          !(boardCell.topRightCell?.isOccupied ?? false) &&
          !(boardCell.rightCell?.isOccupied ?? false) &&
          !(boardCell.bottomRightCell?.isOccupied ?? false) &&
          !(boardCell.bottomCell?.isOccupied ?? false) &&
          !(boardCell.bottomLeftCell?.isOccupied ?? false) &&
          !(boardCell.leftCell?.isOccupied ?? false) &&
          !(boardCell.topLeftCell?.isOccupied ?? false)) {
        result.add(boardCell.index);
      }
      if (ship.shipAxis == Axis.horizontal) {
        boardCell = boardCell.rightCell;
      } else {
        boardCell = boardCell.bottomCell;
      }

      shipSize--;
    }

    return result.length == ship.shipType.size ? result : [];
  }

  GameBoardCell addShipToBoard(List<int> indexes) {
    GameBoardCell boardCell = gameBoardCell;
    for (int i = 0; i < indexes.length; i++) {
      boardCell = _goToCellWithIndex(indexes[i], boardCell);
      boardCell.setCellState = CellState.occupied;
    }
    return boardCell;
  }

  GameBoardCell removeShipByIndex(int index) {
    final indexes = _detectShipIndexesByIndex(index);
    GameBoardCell boardCell = gameBoardCell;
    for (int i = 0; i < indexes.length; i++) {
      boardCell = _goToCellWithIndex(indexes[i], boardCell);
      boardCell.setCellState = CellState.empty;
    }

    return boardCell;
  }

  List<int> _detectShipIndexesByIndex(int index) {
    final List<int> indexes = [index];

    final boardCell = _goToCellWithIndex(index, gameBoardCell);

    GameBoardCell? leftCell = boardCell.leftCell;
    GameBoardCell? rightCell = boardCell.rightCell;
    while (rightCell != null) {
      if (rightCell.isOccupied) {
        indexes.add(rightCell.index);
        rightCell = rightCell.rightCell;
      } else {
        break;
      }
    }
    while (leftCell != null) {
      if (leftCell.isOccupied) {
        indexes.add(leftCell.index);
        leftCell = leftCell.leftCell;
      } else {
        break;
      }
    }

    GameBoardCell? topCell = boardCell.topCell;
    GameBoardCell? bottomCell = boardCell.bottomCell;

    while (topCell != null) {
      if (topCell.isOccupied) {
        indexes.add(topCell.index);
        topCell = topCell.topCell;
      } else {
        break;
      }
    }

    while (bottomCell != null) {
      if (bottomCell.isOccupied) {
        indexes.add(bottomCell.index);
        bottomCell = bottomCell.bottomCell;
      } else {
        break;
      }
    }

    return indexes;
  }

  Ship detectShipByIndex(int index) {
    int shipSize = 1;
    final boardCell = _goToCellWithIndex(index, gameBoardCell);
    GameBoardCell? leftCell = boardCell.leftCell;
    GameBoardCell? rightCell = boardCell.rightCell;
    GameBoardCell? topCell = boardCell.topCell;
    GameBoardCell? bottomCell = boardCell.bottomCell;

    while (rightCell != null) {
      if (rightCell.isOccupied) {
        shipSize++;
        rightCell = rightCell.rightCell;
      } else {
        break;
      }
    }

    while (leftCell != null) {
      if (leftCell.isOccupied) {
        shipSize++;
        leftCell = leftCell.leftCell;
      } else {
        break;
      }
    }

    if (shipSize > 1) {
      return Ship(
        shipAxis: Axis.horizontal,
        shipType:
            ShipType.values.firstWhere((shipType) => shipType.size == shipSize),
      );
    }

    while (topCell != null) {
      if (topCell.isOccupied) {
        shipSize++;
        topCell = topCell.topCell;
      } else {
        break;
      }
    }

    while (bottomCell != null) {
      if (bottomCell.isOccupied) {
        shipSize++;
        bottomCell = bottomCell.bottomCell;
      } else {
        break;
      }
    }

    return Ship(
      shipAxis: Axis.vertical,
      shipType:
          ShipType.values.firstWhere((shipType) => shipType.size == shipSize),
    );
  }

  GameBoardCell _goToCellWithIndex(int index, GameBoardCell boardCell) {
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
    return boardCell;
  }

  List<int> findOccupiedIndexes() {
    final List<int> res = [];

    GameBoardCell? cell = _goToCellWithIndex(0, gameBoardCell);

    while (cell != null) {
      if (cell.isOccupied) {
        res.add(cell.index);
      }

      GameBoardCell? rightCell = cell.rightCell;
      GameBoardCell? bottomCell = cell.bottomCell;
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
