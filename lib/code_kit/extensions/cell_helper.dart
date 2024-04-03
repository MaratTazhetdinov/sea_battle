part of '../code_kit_part.dart';

extension CellHelper on Cell {
  /// Detects ship occupuied indexes by [index].
  List<int> detectShipIndexesByIndex(int index) {
    final List<int> indexes = [index];

    final newCell = goToCellWithIndex(index);

    Cell? leftCell = newCell.leftCell;
    Cell? rightCell = newCell.rightCell;
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

    Cell? topCell = newCell.topCell;
    Cell? bottomCell = newCell.bottomCell;

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
    indexes.sort();
    return indexes;
  }

  /// Returns cell with [index].
  Cell goToCellWithIndex(int index) {
    Cell cell = this;
    final currentIndex = cell.index;
    int horizontalDiff = (currentIndex % 10) - (index % 10);
    if (horizontalDiff < 0) {
      while (horizontalDiff != 0) {
        if (cell.rightCell case final rightCell?) {
          cell = rightCell;
        }
        horizontalDiff++;
      }
    } else if (horizontalDiff > 0) {
      while (horizontalDiff != 0) {
        if (cell.leftCell case final leftCell?) {
          cell = leftCell;
        }
        horizontalDiff--;
      }
    }
    int verticalDiff =
        (currentIndex - (currentIndex % 10)) - (index - (index % 10));
    if (verticalDiff < 0) {
      while (verticalDiff != 0) {
        if (cell.bottomCell case final bottomCell?) {
          cell = bottomCell;
        }
        verticalDiff += 10;
      }
    } else if (verticalDiff > 0) {
      while (verticalDiff != 0) {
        if (cell.topCell case final topCell?) {
          cell = topCell;
        }
        verticalDiff -= 10;
      }
    }
    return cell;
  }

  /// Finds occupuied indexes in all cells.
  List<int> findOccupiedIndexes() {
    final List<int> res = [];

    Cell? cell = goToCellWithIndex(0);

    while (cell != null) {
      if (cell.isOccupied) {
        res.add(cell.index);
      }

      Cell? rightCell = cell.rightCell;
      Cell? bottomCell = cell.bottomCell;
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
