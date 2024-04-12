part of '../game_session_list_part.dart';

abstract class GameSessionListEvent {}

class GameSessionListReloaded extends GameSessionListEvent {}

class _GameSessionListChanged extends GameSessionListEvent {
  final List<GameSession> gameSessionList;

  _GameSessionListChanged(this.gameSessionList);
}
