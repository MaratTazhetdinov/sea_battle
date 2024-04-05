part of '../../game_session_part.dart';

class DtoGameSession {
  final String gameSessionId;
  final List<DtoGameBoard> dtoGameBoards;

  DtoGameSession({
    required this.gameSessionId,
    required this.dtoGameBoards,
  });

  factory DtoGameSession.fromFirebaseDatabase(
      String gameSessionId, Object? data) {
    final json = Map<String, dynamic>.from(data! as Map<Object?, Object?>);
    return DtoGameSession(
      gameSessionId: gameSessionId,
      dtoGameBoards: json.keys
          .map(
            (key) => DtoGameBoard(
              userId: key,
              cells: List<int>.from(json[key]['cells']),
            ),
          )
          .toList(),
    );
  }
}
