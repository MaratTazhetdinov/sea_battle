part of '../game_session_part.dart';

@copyWith
@props
class GameSessionState extends Equatable {
  final GameSession gameSession;

  const GameSessionState({required this.gameSession});

  @override
  List<Object?> get props => _$GameSessionStateProps(this);
}

class GameSessionFailed extends GameSessionState {
  final Object? error;

  const GameSessionFailed(this.error, GameSession gameSession)
      : super(gameSession: gameSession);
}
