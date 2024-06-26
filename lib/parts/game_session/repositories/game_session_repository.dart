part of '../game_session_part.dart';

/// [GameSessionRepository].
class GameSessionRepository extends IGameSessionRepository {
  /// [IGameSessionDataProvider].
  final IGameSessionDataProvider gameSessionDataProvider;

  GameSessionRepository({required this.gameSessionDataProvider});

  @override
  Stream<GameSession?> getGameSession(
    String gameSessionId,
  ) =>
      gameSessionDataProvider
          .getGameSession(gameSessionId)
          .map((dtoGameSession) {
        if (dtoGameSession case final dto?) {
          return GameSession.fromDto(dto);
        }
        return null;
      });

  @override
  Stream<List<GameSession>> get gameSessionsList =>
      gameSessionDataProvider.gameSessionsList.map((dtoList) => dtoList
          .map((dtoGameSession) => GameSession.fromDto(dtoGameSession))
          .toList());

  @override
  Future<void> shoot({
    required String userId,
    required String gameSessionId,
    required int cellIndex,
    required int cellState,
    required String nextTurnUserId,
  }) async {
    await gameSessionDataProvider.shoot(
      userId: userId,
      gameSessionId: gameSessionId,
      cellIndex: cellIndex,
      cellState: cellState,
      nextTurnUserId: nextTurnUserId,
    );
  }

  @override
  Future<void> surrender({
    required String userId,
    required String gameSessionId,
    required List<int> cells,
  }) async {
    await gameSessionDataProvider.surrender(
        userId: userId, gameSessionId: gameSessionId, cells: cells);
  }

  @override
  Future<void> finishShipsAlignment({
    required String userId,
    required String gameSessionId,
    required List<int> cells,
    String? currentTurnUserId,
  }) async {
    await gameSessionDataProvider.finishShipsAlignment(
      userId: userId,
      gameSessionId: gameSessionId,
      cells: cells,
      currentTurnUserId: currentTurnUserId,
    );
  }

  @override
  Future<void> removeGameSession({required String gameSessionId}) async {
    await gameSessionDataProvider.removeGameSession(
        gameSessionId: gameSessionId);
  }
}
