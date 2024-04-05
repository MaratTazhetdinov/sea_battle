part of '../game_session_list_part.dart';

@props
sealed class GameSessionListState extends Equatable {
  final List<GameSession> gameSessionList;

  const GameSessionListState(this.gameSessionList);

  @override
  List<Object?> get props => _$GameSessionListStateProps(this);
}

class GameSessionListInit extends GameSessionListState {
  const GameSessionListInit() : super(const []);
}

class GameSessionListSuccess extends GameSessionListState {
  final List<GameSession> list;

  const GameSessionListSuccess(this.list) : super(list);
}

class GameSessionListFailure extends GameSessionListState {
  final Object error;

  const GameSessionListFailure(this.error) : super(const []);
}
