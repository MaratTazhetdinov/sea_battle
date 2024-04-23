part of '../game_session_part.dart';

abstract class IGameSessionRepository {
  Stream<GameSession> getGameSession(
    String gameSessionId,
  );

  Stream<List<GameSession>> get gameSessionsList;

  Future<void> shoot({
    required String userId,
    required String gameSessionId,
    required int cellIndex,
    required int cellState,
    required String nextTurnUserId,
  });

  Future<void> surrender({
    required String userId,
    required String gameSessionId,
    required List<int> cells,
  });

  Future<void> finishShipsAlignment({
    required String userId,
    required String gameSessionId,
    required List<int> cells,
    String? currentTurnUserId,
  });
}
