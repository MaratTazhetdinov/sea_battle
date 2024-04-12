part of '../game_session_part.dart';

abstract class IGameSessionDataProvider {
  Stream<DtoGameSession> getGameSession(
    String gameSessionId,
  );

  Stream<List<DtoGameSession>> get gameSessionsList;

  Future<void> shoot({
    required String userId,
    required String gameSessionId,
    required int cellIndex,
    required int cellState,
  });

  Future<void> finishShipsAlignment({
    required String userId,
    required String gameSessionId,
    required List<int> cells,
  });
}
