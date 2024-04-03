part of '../game_session_part.dart';

class FbDbGameSessionDataProvider extends IGameSessionDataProvider {
  final String gameSessionId;
  final FirebaseDatabase db;
  static const ref = 'games';

  FbDbGameSessionDataProvider({
    required this.gameSessionId,
    required this.db,
  });

  @override
  Stream<DtoGameSession> getGameSession(String gameSessionId) {
    return db.ref(ref).child(gameSessionId).onValue.map(
        (data) => DtoGameSession.fromFirebaseDatabase(data.snapshot.value));
  }

  @override
  Stream<List<DtoGameSession>> get gameSessionsList {
    return db.ref(ref).onValue.map((dataList) {
      final list = dataList.snapshot.value as List<Object?>;
      return list
          .map((data) => DtoGameSession.fromFirebaseDatabase(data))
          .toList();
    });
  }

  @override
  Future<void> shoot({
    required String userId,
    required int cellIndex,
    required int cellState,
  }) async {
    await db
        .ref(ref)
        .child(gameSessionId)
        .update({'$userId/cells/$cellIndex': cellState});
  }

  @override
  Future<void> finishShipsAlignment({
    required String userId,
    required String userNickname,
    required List<int> cells,
  }) async {
    final rawCells =
        List.generate(100, (index) => cells.contains(index) ? 1 : 0);
    await db.ref(ref).child(gameSessionId).update(
      {
        userId: {
          'userNickname': userNickname,
          'cells': rawCells,
        },
      },
    );
  }
}
