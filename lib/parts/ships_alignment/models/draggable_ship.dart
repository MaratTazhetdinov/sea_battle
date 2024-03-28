part of '../ships_alignment_part.dart';

class DraggableShip {
  final Ship? ship;
  final Offset offset;

  const DraggableShip({required this.ship, required this.offset});

  DraggableShip.empty({this.ship, this.offset = Offset.zero});
}
