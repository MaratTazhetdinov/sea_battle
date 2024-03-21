part of '../game_session_part.dart';

abstract class IGameSessionDataProvider {
  Stream<DtoGameSession> get gameSession;

  Future<void> shoot({
    required String userId,
    required int cellIndex,
    required int cellState,
  });

  Future<void> finishShipsAlignment({
    required String userId,
    required List<int> cells,
  });
}
