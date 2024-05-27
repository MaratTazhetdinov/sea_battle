part of '../../game_session_part.dart';

/// [DtoGameSession].
class DtoGameSession {
  /// Game session id.
  final String gameSessionId;

  /// List of [DtoGameBoard].
  final List<DtoGameBoard> dtoGameBoards;

  /// Shows which user id should shoot now.
  final String currentTurnUserId;

  DtoGameSession({
    required this.gameSessionId,
    required this.dtoGameBoards,
    required this.currentTurnUserId,
  });

  /// Factory constructor from FirebaseDatabase object.
  factory DtoGameSession.fromFirebaseDatabase(
      String gameSessionId, Object data) {
    final json = Map<String, dynamic>.from(data as Map<Object?, Object?>);
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
