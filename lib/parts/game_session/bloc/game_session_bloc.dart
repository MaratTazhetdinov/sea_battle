part of '../game_session_part.dart';

class GameSessionBloc extends Bloc<GameSessionEvent, GameSessionState> {
  final IGameSessionRepository gameSessionRepository;
  StreamSubscription<GameSession>? _gameSessionSubscription;

  GameSessionBloc({required this.gameSessionRepository})
      : super(GameSessionInitial()) {
    _gameSessionSubscription = gameSessionRepository.gameSession
        .listen((gameSession) => add(_GameSessionChanged(gameSession)));
    on<_GameSessionChanged>(_onGameSessionChanged);
    on<GameSessionShipsAlignmentFinished>(_onShipsAlignmentFinished);
    on<GameSessionUserShot>(_onUserShot);
  }

  Future<void> _onGameSessionChanged(
      _GameSessionChanged event, Emitter<GameSessionState> emit) async {
    try {
      emit(GameSessionLoaded(event.gameSession));
    } catch (e) {
      emit(GameSessionFailed(e));
    }
  }

  Future<void> _onShipsAlignmentFinished(
      GameSessionShipsAlignmentFinished event,
      Emitter<GameSessionState> emit) async {
    try {
      ///TODO add game logic
      gameSessionRepository.finishShipsAlignment(
          userId: '', cells: event.cells);
    } catch (e) {
      emit(GameSessionFailed(e));
    }
  }

  Future<void> _onUserShot(
      GameSessionUserShot event, Emitter<GameSessionState> emit) async {
    try {
      ///TODO add game logic
      gameSessionRepository.shoot(userId: 'userId', cellIndex: 0, cellState: 0);
    } catch (e) {
      emit(GameSessionFailed(e));
    }
  }

  @override
  Future<void> close() {
    _gameSessionSubscription?.cancel();
    return super.close();
  }
}

/// Context extension for quick access to [GameSessionBloc].
extension GameSessionBlocBuildContextX on BuildContext {
  /// Instance of [GameSessionBloc].
  GameSessionBloc get readGameSessionBloc => read<GameSessionBloc>();
}
