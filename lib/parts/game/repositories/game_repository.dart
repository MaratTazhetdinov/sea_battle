part of '../game_part.dart';

class GameRepository extends IGameRepository {
  final IGameDataProvider iGameDataProvider;

  GameRepository({required this.iGameDataProvider});

  @override
  Game get gameData => throw UnimplementedError();

  @override
  void shoot() {
    iGameDataProvider.shoot();
  }

  @override
  void finishShipsArrangment() {
    // TODO: implement finishShipsArrangment
  }

  @override
  void giveUpGame() {
    // TODO: implement giveUpGame
  }
}
