part of '../game_session_part.dart';

class GameSessionRepository extends IGameSessionRepository {
  final IGameSessionDataProvider gameSessionDataProvider;

  GameSessionRepository({required this.gameSessionDataProvider});

  @override
  Stream<GameSession> getGameSession(
    String gameSessionId,
  ) =>
      gameSessionDataProvider
          .getGameSession(gameSessionId)
          .map((dtoGameSession) => GameSession.fromDto(dtoGameSession));

  @override
  Stream<List<GameSession>> get gameSessionsList =>
      gameSessionDataProvider.gameSessionsList.map((dtoList) => dtoList
          .map((dtoGameSession) => GameSession.fromDto(dtoGameSession))
          .toList());

  @override
  Future<void> shoot(
      {required String userId,
      required String gameSessionId,
      required int cellIndex,
      required int cellState}) async {
    await gameSessionDataProvider.shoot(
      userId: userId,
      gameSessionId: gameSessionId,
      cellIndex: cellIndex,
      cellState: cellState,
    );
  }

  @override
  Future<void> finishShipsAlignment({
    required String userId,
    required String gameSessionId,
    required List<int> cells,
  }) async {
    await gameSessionDataProvider.finishShipsAlignment(
      userId: userId,
      gameSessionId: gameSessionId,
      cells: cells,
    );
  }
}