part of '../ships_alignment_part.dart';

class Board {
  final int cellsNumber;
  List<int> occupiedIndexes = [];
  BoardCell boardCell;
  List<(Ship, List<int>)> ships = [];

  Board({
    required this.cellsNumber,
  }) : boardCell = _createBoard(cellsNumber);

  List<int> addShipToBoard({required int index, required Ship ship}) {
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

    print(result);
    return result.length == ship.shipType.size ? result : [];
  }

  void addShip(
    List<int> indexes,
  ) {
    for (int i = 0; i < indexes.length; i++) {
      _goToCellWithIndex(indexes[i]);
      boardCell.isOccupied = true;
    }
    occupiedIndexes.addAll(indexes);
  }

  void addShip2(List<int> indexes, Ship ship) {
    for (int i = 0; i < indexes.length; i++) {
      _goToCellWithIndex(indexes[i]);
      boardCell.isOccupied = true;
    }
    ships.add((ship, indexes));
  }

  bool isOccupied(int index) {
    for (final result in ships) {
      if (result.$2.contains(index)) {
        return true;
      }
    }
    return false;
  }

  Ship getShipByIndex(int index) {
    (Ship, List<int>)? res;
    int index = 0;
    for (int i = 0; i < ships.length; i++) {
      if (ships[i].$2.contains(index)) {
        index = i;
        res = ships[i];
      }
    }
    return res?.$1 ?? Ship(shipType: ShipType.four, shipAxis: Axis.vertical);
  }

  void removeShipByIndex(int index) {
    (Ship, List<int>)? res;
    int indx = 0;
    for (int i = 0; i < ships.length; i++) {
      if (ships[i].$2.contains(index)) {
        indx = i;
        res = ships[i];
      }
    }
    if (res case final res?) {
      for (int i = 0; i < res.$2.length; i++) {
        _goToCellWithIndex(res.$2[i]);
        boardCell.isOccupied = false;
      }
      ships.removeAt(indx);
    }
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
}
