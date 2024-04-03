part of '../game_session_list_part.dart';

class GameSessionListBloc
    extends Bloc<GameSessionListEvent, GameSessionListState> {
  final IGameSessionRepository gameSessionRepository;

  StreamSubscription<List<GameSession>>? _gameSessionListSubscription;

  GameSessionListBloc({required this.gameSessionRepository})
      : super(const GameSessionListInit()) {
    _startListen();
    on<_GameSessionListChanged>(_onGameSessionListChanged);
    on<GameSessionListReloaded>(_onGameSessionListReloaded);
  }

  void _startListen() {
    _gameSessionListSubscription = gameSessionRepository.gameSessionsList
        .listen((list) => add(_GameSessionListChanged(list)));
  }

  Future<void> _onGameSessionListChanged(
      _GameSessionListChanged event, Emitter<GameSessionListState> emit) async {
    try {
      emit(GameSessionListSuccess(event.gameSessionList
          .where((session) => session.isWaitingForPlayer)
          .toList()));
    } catch (e) {
      emit(GameSessionListFailure(e));
    }
  }

  Future<void> _onGameSessionListReloaded(
      GameSessionListReloaded event, Emitter<GameSessionListState> emit) async {
    emit(const GameSessionListInit());
    _startListen();
  }

  @override
  Future<void> close() {
    _gameSessionListSubscription?.cancel();
    return super.close();
  }
}
