part of '../game_session_part.dart';

class GameSession {
  final List<GameBoard> gameBoards;

  const GameSession({
    required this.gameBoards,
  });

  bool get isWaitingForPlayer => gameBoards.length == 1;

  factory GameSession.fromDto(DtoGameSession dtoGameSession) => GameSession(
        gameBoards: dtoGameSession.dtoGameBoards
            .map((dtoGameBoard) => GameBoard.fromDto(dtoGameBoard))
            .toList(),
      );
}
