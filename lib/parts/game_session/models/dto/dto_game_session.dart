part of '../../game_session_part.dart';

class DtoGameSession {
  final String gameSessionId;
  final List<DtoGameBoard> dtoGameBoards;
  final String currentTurnUserId;

  DtoGameSession({
    required this.gameSessionId,
    required this.dtoGameBoards,
    required this.currentTurnUserId,
  });

  factory DtoGameSession.fromFirebaseDatabase(
      String gameSessionId, Object? data) {
    final json = Map<String, dynamic>.from(data! as Map<Object?, Object?>);
    return DtoGameSession(
      gameSessionId: gameSessionId,
      dtoGameBoards: json.keys
          .where((key) => key != 'currentTurnUserId')
          .map(
            (key) => DtoGameBoard(
              userId: key,
              cells: List<int>.from(json[key]['cells']),
            ),
          )
          .toList(),
      currentTurnUserId: json['currentTurnUserId'],
    );
  }
}
