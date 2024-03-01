part of '../game_session_part.dart';

class FirebaseDatabaseGameSessionDataProvider extends IGameSessionDataProvider {
  final String gameSessionId;
  final FirebaseDatabase db;

  FirebaseDatabaseGameSessionDataProvider({
    required this.gameSessionId,
    required this.db,
  });

  @override
  Stream<DtoGameSession> get gameSession {
    // db.ref('games').child('').onChildChanged
    throw Exception();
  }
  // db.ref('games').onChildChanged.map((event) {
  //   final json = event.snapshot.value as Map<String, dynamic>;
  //   debugPrint(json.toString());
  //   return const DtoGameSession();
  // });

  @override
  Future<void> shoot() async {}
}
