part of '../game_session_part.dart';

/// [GameSession].
class GameSession {
  /// Game session id.
  final String gameSessionId;

  /// List of [GameBoard].
  final List<GameBoard> gameBoards;

  /// Shows which user id should shoot now.
  final String currentTurnUserId;

  const GameSession({
    required this.gameSessionId,
    required this.gameBoards,
    required this.currentTurnUserId,
  });

  /// Getter for determining how many players are currently in the session.
  bool get isWaitingForPlayer => gameBoards.length == 1;

  /// Factory constructor from [DtoGameSession].
  factory GameSession.fromDto(DtoGameSession dtoGameSession) => GameSession(
        gameSessionId: dtoGameSession.gameSessionId,
        gameBoards: dtoGameSession.dtoGameBoards
            .map((dtoGameBoard) => GameBoard.fromDto(dtoGameBoard))
            .toList(),
        currentTurnUserId: dtoGameSession.currentTurnUserId,
      );
}
