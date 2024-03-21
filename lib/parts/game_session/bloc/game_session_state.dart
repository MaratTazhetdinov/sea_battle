part of '../game_session_part.dart';

@copyWith
@props
class GameSessionState extends Equatable {
  @override
  List<Object?> get props => _$GameSessionStateProps(this);
}

class GameSessionInitial extends GameSessionState {}

class GameSessionLoaded extends GameSessionState {
  final GameSession gameSession;

  GameSessionLoaded(this.gameSession);
}

class GameSessionFailed extends GameSessionState {
  final Object error;
  GameSessionFailed(this.error);
}
