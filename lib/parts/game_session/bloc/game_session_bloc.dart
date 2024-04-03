part of '../game_session_part.dart';

class GameSessionBloc extends Bloc<GameSessionEvent, GameSessionState> {
  final IGameSessionRepository gameSessionRepository;
  final String userId;
  late GameLogic gameLogic;
  StreamSubscription<GameSession>? _gameSessionSubscription;

  GameSessionBloc({required this.gameSessionRepository, required this.userId})
      : super(const GameSessionState(
          gameSession: GameSession(gameBoards: []),
        )) {
    _gameSessionSubscription = gameSessionRepository.gameSession
        .listen((gameSession) => add(_GameSessionChanged(gameSession)));
    on<_GameSessionChanged>(_onGameSessionChanged);
    on<GameSessionShipsAlignmentFinished>(_onShipsAlignmentFinished);
    on<GameSessionUserShot>(_onUserShot);
  }

  Future<void> _onGameSessionChanged(
      _GameSessionChanged event, Emitter<GameSessionState> emit) async {
    try {
      final gameBoards = event.gameSession.gameBoards;
      if (gameBoards.length == 2) {
        // gameLogic = GameLogic(
        //   userBoard:
        //       gameBoards.firstWhere((gameBoard) => gameBoard.userId == userId),
        //   enemyBoard:
        //       gameBoards.firstWhere((gameBoard) => gameBoard.userId != userId),
        // );
      }
      emit(state.copyWith(gameSession: event.gameSession));
    } catch (e) {
      emit(GameSessionFailed(e, state.gameSession));
    }
  }

  Future<void> _onShipsAlignmentFinished(
      GameSessionShipsAlignmentFinished event,
      Emitter<GameSessionState> emit) async {
    try {
      gameSessionRepository.finishShipsAlignment(
          userId: '', cells: event.cells);
    } catch (e) {
      emit(GameSessionFailed(e, state.gameSession));
    }
  }

  Future<void> _onUserShot(
      GameSessionUserShot event, Emitter<GameSessionState> emit) async {
    try {
      final cellState = gameLogic.shoot(event.cellIndex);
      if (cellState case final state?) {
        gameSessionRepository.shoot(
          userId: gameLogic.enemyBoard.userId,
          cellIndex: event.cellIndex,
          cellState: state,
        );
      }
    } catch (e) {
      emit(GameSessionFailed(e, state.gameSession));
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
