part of '../game_session_part.dart';

class GameSessionBloc extends Bloc<GameSessionEvent, GameSessionState> {
  final IGameSessionRepository gameSessionRepository;
  final String userId;
  final String gameSessionId;
  StreamSubscription<GameSession>? _gameSessionSubscription;
  late GameLogic gameLogic;

  GameSessionBloc(
      {required this.gameSessionRepository,
      required this.userId,
      required this.gameSessionId})
      : super(GameSessionState(
          gameSession: GameSession(
            gameSessionId: gameSessionId,
            gameBoards: [],
            currentTurnUserId: '',
          ),
        )) {
    _gameSessionSubscription = gameSessionRepository
        .getGameSession(gameSessionId)
        .listen((gameSession) => add(_GameSessionChanged(gameSession)));
    on<_GameSessionChanged>(_onGameSessionChanged);
    on<GameSessionUserShot>(_onUserShot);
    on<GameSessionCompleted>(_onGameSessionCompleted);
    on<GameSessionUserSurrendered>(_onGameSessionUserSurrendered);
  }

  Future<void> _onGameSessionChanged(
      _GameSessionChanged event, Emitter<GameSessionState> emit) async {
    try {
      gameLogic = GameLogic.fromGameSession(event.gameSession, userId);
      emit(state.copyWith(gameSession: event.gameSession));
    } catch (e) {
      emit(GameSessionFailure(e, state.gameSession));
    }
  }

  Future<void> _onUserShot(
      GameSessionUserShot event, Emitter<GameSessionState> emit) async {
    try {
      final cellState = gameLogic.shoot(event.cellIndex);
      if (cellState case final cellState?) {
        gameSessionRepository.shoot(
          gameSessionId: state.gameSession.gameSessionId,
          userId: gameLogic.enemyBoard.userId,
          cellIndex: event.cellIndex,
          cellState: cellState,
          nextTurnUserId: gameLogic.enemyBoard.userId,
        );
      }
    } catch (e) {
      emit(GameSessionFailure(e, state.gameSession));
    }
  }

  Future<void> _onGameSessionCompleted(
      GameSessionCompleted event, Emitter<GameSessionState> emit) async {
    emit(GameSessionComplete(
      event.isUserWon,
      state.gameSession,
    ));
  }

  Future<void> _onGameSessionUserSurrendered(
      GameSessionUserSurrendered event, Emitter<GameSessionState> emit) async {
    final previousCells = state.gameSession.gameBoards
        .firstWhere((gameBoard) => gameBoard.userId == userId)
        .cell
        .getCellsState();
    final List<int> cells = previousCells.map((cellState) {
      if (cellState == CellState.occupied) {
        return CellState.destroyed.value;
      }
      return cellState.value;
    }).toList();
    await gameSessionRepository.surrender(
      userId: userId,
      gameSessionId: gameSessionId,
      cells: cells,
    );
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
