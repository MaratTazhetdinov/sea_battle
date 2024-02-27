part of '../game_part.dart';

abstract class IGameDataProvider {
  Stream<DtoGame> get dtoGame;

  void shoot();

  void startGame();

  void giveUp();
}
