part of '../ships_alignment_part.dart';

/// Logic for ships alignment.
class ShipsAlignmentLogic {
  /// Checks possible indexes according to current [index] and [ship].
  static List<int> checkPossibleAlignment({
    required int index,
    required Ship ship,
    required Cell cell,
  }) {
    Cell? newCell = cell.goToCellWithIndex(index);
    final List<int> result = [];
    int shipSize = ship.shipType.size;

    while (shipSize != 0 && newCell != null) {
      if (!(newCell.topCell?.isOccupied ?? false) &&
          !(newCell.topRightCell?.isOccupied ?? false) &&
          !(newCell.rightCell?.isOccupied ?? false) &&
          !(newCell.bottomRightCell?.isOccupied ?? false) &&
          !(newCell.bottomCell?.isOccupied ?? false) &&
          !(newCell.bottomLeftCell?.isOccupied ?? false) &&
          !(newCell.leftCell?.isOccupied ?? false) &&
          !(newCell.topLeftCell?.isOccupied ?? false)) {
        result.add(newCell.index);
      }
      if (ship.shipAxis == Axis.horizontal) {
        newCell = newCell.rightCell;
      } else {
        newCell = newCell.bottomCell;
      }

      shipSize--;
    }

    return result.length == ship.shipType.size ? result : [];
  }
}
