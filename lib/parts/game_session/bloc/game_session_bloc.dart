part of '../game_session_part.dart';

/// Bloc for ship alignment.
class GameSessionBloc extends Bloc<GameSessionEvent, GameSessionState> {
  /// Game session repository to interact with backend.
  final IGameSessionRepository gameSessionRepository;

  /// Profile repository to interact with backend.
  final IProfileRepository profileRepository;

  /// User Id.
  final String userId;

  /// Game Session Id.
  final String gameSessionId;

  /// Stream subscription for listening [GameSession].
  StreamSubscription<GameSession>? _gameSessionSubscription;

  /// Game logic class.
  late GameLogic gameLogic;

  GameSessionBloc(
      {required this.gameSessionRepository,
      required this.profileRepository,
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
    on<UserProfileStatisticUpdated>(_onUserProfileStatisticUpdated);
  }

  /// Updates states when new [GameSession] received from backend.
  Future<void> _onGameSessionChanged(
      _GameSessionChanged event, Emitter<GameSessionState> emit) async {
    try {
      gameLogic = GameLogic.fromGameSession(event.gameSession, userId);
      emit(state.copyWith(gameSession: event.gameSession));
    } catch (e) {
      emit(GameSessionFailure(e, state.gameSession));
    }
  }

  /// Registers user shot.
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

  /// Registers the end of the game.
  Future<void> _onGameSessionCompleted(
      GameSessionCompleted event, Emitter<GameSessionState> emit) async {
    emit(GameSessionComplete(
      event.isUserWon,
      state.gameSession,
    ));
  }

  /// Registered user surrender.
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

  /// Updates users wins and loss statictic.
  Future<void> _onUserProfileStatisticUpdated(UserProfileStatisticUpdated event,
      Emitter<GameSessionState> state) async {
    await profileRepository.updateProfileStatistic(isWinner: true, id: userId);
    await profileRepository.updateProfileStatistic(
        isWinner: false, id: gameLogic.enemyBoard.userId);
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
