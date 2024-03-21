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
  Stream<DtoGameSession> get gameSession {
    return db.ref(ref).child(gameSessionId).onValue.map(
        (data) => DtoGameSession.fromFirebaseDatabase(data.snapshot.value));
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
    required List<int> cells,
  }) async {
    db.ref(ref).child(gameSessionId).update(
      {
        userId: {
          'cells': cells,
        },
      },
    );
  }
}
