part of '../../game_session_part.dart';

class DtoGameSession {
  final List<DtoGameBoard> dtoGameBoards;

  DtoGameSession({
    required this.dtoGameBoards,
  });

  factory DtoGameSession.fromFirebaseDatabase(Object? data) {
    final json = Map<String, dynamic>.from(data! as Map<Object?, Object?>);
    return DtoGameSession(
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
