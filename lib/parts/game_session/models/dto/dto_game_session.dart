part of '../../game_session_part.dart';

class DtoGameSession {
  final DtoGameBoard? firstPlayerBoard;
  final DtoGameBoard? secondPlayerBoard;

  const DtoGameSession({
    this.firstPlayerBoard,
    this.secondPlayerBoard,
  });

  factory DtoGameSession.fromFirebaseDatabase(Object? data) {
    final json = Map<String, dynamic>.from(data! as Map<Object?, Object?>);
    return DtoGameSession(
      firstPlayerBoard:
          DtoGameBoard.fromFirebaseDatabase(json['firstPlayerBoard']),
      secondPlayerBoard:
          DtoGameBoard.fromFirebaseDatabase(json['secondPlayerBoard']),
    );
  }
}
