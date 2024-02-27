part of '../game_part.dart';

abstract class IGameRepository {
  Game get gameData;

  void shoot();

  void finishShipsArrangment();

  void giveUpGame();
}
