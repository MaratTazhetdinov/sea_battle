part of '../game_session_part.dart';

@copyWith
@props

/// State for [GameSessionState].
class GameSessionState extends Equatable {
  /// [GameSession].
  final GameSession gameSession;

  const GameSessionState({required this.gameSession});

  @override
  List<Object?> get props => _$GameSessionStateProps(this);
}

/// State for [GameSessionFailure].
class GameSessionFailure extends GameSessionState {
  /// Error.
  final Object? error;

  const GameSessionFailure(this.error, GameSession gameSession)
      : super(gameSession: gameSession);
}

/// State for [GameSessionComplete].
class GameSessionComplete extends GameSessionState {
  /// Determines whether the user won or not.
  final bool isUserWon;

  const GameSessionComplete(this.isUserWon, GameSession gameSession)
      : super(gameSession: gameSession);
}
