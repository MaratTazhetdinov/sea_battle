part of '../../game_session_part.dart';

class DtoGameSession {
  final List<DtoGameBoard> gameBoards;

  DtoGameSession({
    required this.gameBoards,
  });

  factory DtoGameSession.fromFirebaseDatabase(Object? data) {
    final json = List<Map<Object?, Object?>>.from(data! as List<Object?>);

    return DtoGameSession(
      gameBoards:
          json.map((item) => DtoGameBoard.fromFirebaseDatabase(item)).toList(),
    );
  }
}
