part of '../../game_session_part.dart';

class DtoGameSession {
  final List<DtoGameBoard> gameBoards;

  DtoGameSession({
    required this.gameBoards,
  });

  factory DtoGameSession.fromFirebaseDatabase(Object? data) {
    final json = Map<String, dynamic>.from(data! as Map<Object?, Object?>);
    return DtoGameSession(
      gameBoards: json.keys
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
