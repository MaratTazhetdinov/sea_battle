part of '../game_session_part.dart';

abstract class IGameSessionRepository {
  Stream<GameSession> getGameSession(String gameSessionId);

  Stream<List<GameSession>> get gameSessionsList;

  Future<void> shoot({
    required String userId,
    required int cellIndex,
    required int cellState,
  });

  Future<void> finishShipsAlignment({
    required String userId,
    required String userNickname,
    required List<int> cells,
  });
}
