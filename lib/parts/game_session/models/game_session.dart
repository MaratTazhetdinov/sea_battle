part of '../game_session_part.dart';

class GameSession {
  final String gameSessionId;
  final List<GameBoard> gameBoards;
  final String currentTurnUserId;

  const GameSession({
    required this.gameSessionId,
    required this.gameBoards,
    required this.currentTurnUserId,
  });

  bool get isWaitingForPlayer => gameBoards.length == 1;

  factory GameSession.fromDto(DtoGameSession dtoGameSession) => GameSession(
        gameSessionId: dtoGameSession.gameSessionId,
        gameBoards: dtoGameSession.dtoGameBoards
            .map((dtoGameBoard) => GameBoard.fromDto(dtoGameBoard))
            .toList(),
        currentTurnUserId: dtoGameSession.currentTurnUserId,
      );
}
