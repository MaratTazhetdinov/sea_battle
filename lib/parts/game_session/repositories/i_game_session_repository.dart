part of '../game_session_part.dart';

/// [IGameSessionRepository].
abstract class IGameSessionRepository {
  /// Stream for listening [GameSession].
  Stream<GameSession?> getGameSession(
    String gameSessionId,
  );

  /// Stream for listening list of [GameSession].
  Stream<List<GameSession>> get gameSessionsList;

  /// Registers user shot.
  Future<void> shoot({
    required String userId,
    required String gameSessionId,
    required int cellIndex,
    required int cellState,
    required String nextTurnUserId,
  });

  /// Registers user surrender.
  Future<void> surrender({
    required String userId,
    required String gameSessionId,
    required List<int> cells,
  });

  /// Register completion of ships alignment.
  Future<void> finishShipsAlignment({
    required String userId,
    required String gameSessionId,
    required List<int> cells,
    String? currentTurnUserId,
  });

  /// Removes game session from Database.
  Future<void> removeGameSession({required String gameSessionId});
}
