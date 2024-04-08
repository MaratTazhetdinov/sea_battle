part of '../game_session_list_part.dart';

/// Bloc for loading game session list.
class GameSessionListBloc
    extends Bloc<GameSessionListEvent, GameSessionListState> {
  /// Game session repository to interact with backend.
  final IGameSessionRepository gameSessionRepository;

  /// Profile repository to interact with backend.
  final IProfileRepository profileRepository;

  /// Stream subscription for listening to game session list from backend.
  StreamSubscription<List<GameSession>>? _gameSessionListSubscription;

  GameSessionListBloc({
    required this.gameSessionRepository,
    required this.profileRepository,
  }) : super(const GameSessionListInit()) {
    _startListen();
    on<_GameSessionListChanged>(_onGameSessionListChanged);
    on<GameSessionListReloaded>(_onGameSessionListReloaded);
  }

  /// Starts listen to game session stream.
  void _startListen() {
    _gameSessionListSubscription = gameSessionRepository.gameSessionsList
        .listen((list) => add(_GameSessionListChanged(list)));
  }

  /// Changes state when new data comes from stream.
  Future<void> _onGameSessionListChanged(
      _GameSessionListChanged event, Emitter<GameSessionListState> emit) async {
    try {
      final profiles = await profileRepository.getAllProfiles();
      emit(GameSessionListSuccess(
        event.gameSessionList
            .where((session) => session.isWaitingForPlayer)
            .toList(),
        profiles,
      ));
    } catch (e) {
      emit(GameSessionListFailure(e));
    }
  }

  /// Reloads and starts listen to a new stream.
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

/// Context extension for quick access to [GameSessionListBloc].
extension GameSessionListBlocBuildContextX on BuildContext {
  /// Instance of [GameSessionListBloc].
  GameSessionListBloc get readGameSessionListBloc =>
      read<GameSessionListBloc>();
}
