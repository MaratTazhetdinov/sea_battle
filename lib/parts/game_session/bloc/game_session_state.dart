part of '../game_session_part.dart';

@copyWith
@props
class GameSessionState extends Equatable {
  final GameSession gameSession;

  const GameSessionState({required this.gameSession});

  @override
  List<Object?> get props => _$GameSessionStateProps(this);
}

class GameSessionFailure extends GameSessionState {
  final Object? error;

  const GameSessionFailure(this.error, GameSession gameSession)
      : super(gameSession: gameSession);
}

class GameSessionComplete extends GameSessionState {
  final bool isUserWon;

  const GameSessionComplete(this.isUserWon, GameSession gameSession)
      : super(gameSession: gameSession);
}
