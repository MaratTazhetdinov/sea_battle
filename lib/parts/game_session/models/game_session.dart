part of '../game_session_part.dart';

class GameSession {
  final UserModel firstPlayer;
  final List<Cell> firstPlayerBoard;
  final UserModel secondPlayer;
  final List<Cell> secondPlayerBoard;

  const GameSession({
    required this.firstPlayer,
    required this.firstPlayerBoard,
    required this.secondPlayer,
    required this.secondPlayerBoard,
  });

  factory GameSession.fromDto(DtoGameSession dtoGameSession) {
    return GameSession(
      firstPlayer: dtoGameSession.firstPlayer ?? UserModel.empty,
      firstPlayerBoard: dtoGameSession.firstPlayerBoard
              ?.map((dtoCell) => Cell.fromDto(dtoCell: dtoCell))
              .toList() ??
          [],
      secondPlayer: dtoGameSession.secondPlayer ?? UserModel.empty,
      secondPlayerBoard: dtoGameSession.secondPlayerBoard
              ?.map((dtoCell) => Cell.fromDto(dtoCell: dtoCell))
              .toList() ??
          [],
    );
  }
}
