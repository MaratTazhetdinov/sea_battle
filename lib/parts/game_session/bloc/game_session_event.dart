part of '../game_session_part.dart';

abstract class GameSessionEvent {}

class _GameSessionChanged extends GameSessionEvent {
  final GameSession gameSession;

  _GameSessionChanged(this.gameSession);
}

class GameSessionShipsAlignmentFinished extends GameSessionEvent {
  final List<int> cells;

  GameSessionShipsAlignmentFinished(this.cells);
}

class GameSessionUserShot extends GameSessionEvent {
  final int cellIndex;

  GameSessionUserShot(this.cellIndex);
}
