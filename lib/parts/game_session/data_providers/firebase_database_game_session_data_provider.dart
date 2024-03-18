part of '../game_session_part.dart';

class FirebaseDatabaseGameSessionDataProvider extends IGameSessionDataProvider {
  final String gameSessionId;
  final FirebaseDatabase db;
  static const ref = 'games';

  FirebaseDatabaseGameSessionDataProvider({
    required this.gameSessionId,
    required this.db,
  });

  @override
  Stream<DtoGameSession> get gameSession {
    return FirebaseDatabase.instance.ref(ref).child(gameSessionId).onValue.map(
        (data) => DtoGameSession.fromFirebaseDatabase(data.snapshot.value));
  }

  @override
  Future<void> shoot() async {}
}
