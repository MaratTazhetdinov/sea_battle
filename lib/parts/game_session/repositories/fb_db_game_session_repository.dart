part of '../game_session_part.dart';

class FbDbGameSessionRepository extends IGameSessionRepository {
  final FbDbGameSessionDataProvider fbDbDataProvider;

  FbDbGameSessionRepository({required this.fbDbDataProvider});

  @override
  Stream<GameSession> get gameSession => fbDbDataProvider.gameSession
      .map((dtoGameSession) => GameSession.fromDto(dtoGameSession));

  @override
  Stream<List<GameSession>> get gameSessionsList =>
      fbDbDataProvider.gameSessionsList.map((dtoList) => dtoList
          .map((dtoGameSession) => GameSession.fromDto(dtoGameSession))
          .toList());

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
    required String userNickname,
    required List<int> cells,
  }) async {
    await fbDbDataProvider.finishShipsAlignment(
      userId: userId,
      userNickname: userNickname,
      cells: cells,
    );
  }
}
