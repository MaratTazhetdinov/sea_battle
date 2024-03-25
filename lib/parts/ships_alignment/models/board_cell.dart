part of '../ships_alignment_part.dart';

class BoardCell {
  int index;
  bool isOccupied;
  BoardCell? topCell;
  BoardCell? topRightCell;
  BoardCell? rightCell;
  BoardCell? bottomRightCell;
  BoardCell? bottomCell;
  BoardCell? bottomLeftCell;
  BoardCell? leftCell;
  BoardCell? topLeftCell;

  BoardCell({
    required this.index,
    this.isOccupied = false,
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
