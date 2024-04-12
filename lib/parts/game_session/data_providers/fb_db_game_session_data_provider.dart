part of '../game_session_part.dart';

class FbDbGameSessionDataProvider extends IGameSessionDataProvider {
  final FirebaseDatabase db;
  static const ref = 'games';

  FbDbGameSessionDataProvider({
    required this.db,
  });

  @override
  Stream<DtoGameSession> getGameSession(String gameSessionId) {
    return db.ref(ref).child(gameSessionId).onValue.map((data) =>
        DtoGameSession.fromFirebaseDatabase(
            gameSessionId, data.snapshot.value));
  }

  @override
  Stream<List<DtoGameSession>> get gameSessionsList {
    return db.ref(ref).onValue.map((dataList) {
      if (dataList.snapshot.value case final data?) {
        final list = data as Map<Object?, Object?>;
        return list.entries.map((entry) {
          final gameSessionId = entry.key.toString();
          final data = entry.value;
          return DtoGameSession.fromFirebaseDatabase(gameSessionId, data);
        }).toList();
      } else {
        return [];
      }
    });
  }

  @override
  Future<void> shoot({
    required String userId,
    required String gameSessionId,
    required int cellIndex,
    required int cellState,
    required String nextTurnUserId,
  }) async {
    await db
        .ref(ref)
        .child(gameSessionId)
        .update({'$userId/cells/$cellIndex': cellState});
    if (cellState != 2) {
      await db
          .ref(ref)
          .child(gameSessionId)
          .update({'currentTurnUserId': nextTurnUserId});
    }
  }

  @override
  Future<void> finishShipsAlignment({
    required String userId,
    required String gameSessionId,
    required List<int> cells,
    String? currentTurnUserId,
  }) async {
    final rawCells =
        List.generate(100, (index) => cells.contains(index) ? 1 : 0);
    await db.ref(ref).child(gameSessionId).update(
      {
        if (currentTurnUserId case final userId?) 'currentTurnUserId': userId,
        userId: {
          'cells': rawCells,
        },
      },
    );
  }
}
