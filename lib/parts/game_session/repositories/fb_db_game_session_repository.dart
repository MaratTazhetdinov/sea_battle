part of '../game_session_part.dart';

class FirebaseDatabaseGameSessionRepository extends IGameSessionRepository {
  final FbDbGameSessionDataProvider fbDbDataProvider;

  FirebaseDatabaseGameSessionRepository({required this.fbDbDataProvider});

  @override
  Stream<GameSession> get gameSession => fbDbDataProvider.gameSession
      .map((dtoGameSession) => GameSession.fromDto(dtoGameSession));

  @override
  Future<void> shoot(
      {required String userId,
      required int cellIndex,
      required int cellState}) async {
    await fbDbDataProvider.shoot(
      userId: userId,
      cellIndex: cellIndex,
      cellState: cellState,
    );
  }

  @override
  Future<void> finishShipsAlignment({
    required String userId,
    required List<int> cells,
  }) async {
    await fbDbDataProvider.finishShipsAlignment(
      userId: userId,
      cells: cells,
    );
  }
}
