part of '../game_session_part.dart';

abstract class GameSessionEvent {}

/// Updates state when new [GameSession] received.
class _GameSessionChanged extends GameSessionEvent {
  final GameSession? gameSession;

  _GameSessionChanged(this.gameSession);
}

/// Registers completion of ships alignment.
class GameSessionShipsAlignmentFinished extends GameSessionEvent {
  final List<int> cells;

  GameSessionShipsAlignmentFinished(this.cells);
}

/// Resigters user shot.
class GameSessionUserShot extends GameSessionEvent {
  final int cellIndex;

  GameSessionUserShot(this.cellIndex);
}

/// Register user surrender.
class GameSessionUserSurrendered extends GameSessionEvent {}

/// Register the end of the game.
class GameSessionCompleted extends GameSessionEvent {
  final bool isUserWon;

  GameSessionCompleted(this.isUserWon);
}

/// Updates user profiles statistic.
class UserProfileStatisticUpdated extends GameSessionEvent {}

/// Removes game session from Database.
class GameSessionRemove extends GameSessionEvent {}
