part of '../game_session_part.dart';

@RoutePage()

/// [GameSessionScreen].
class GameSessionScreen extends StatefulWidget {
  /// Game session id.
  final String gameSessionId;

  const GameSessionScreen({
    super.key,
    required this.gameSessionId,
  });

  @override
  State<GameSessionScreen> createState() => _GameSessionScreenState();
}

class _GameSessionScreenState extends State<GameSessionScreen> {
  /// AppLifecycleListener for listeting app state.
  late final AppLifecycleListener _appLifecycleListener;

  /// ValueNotifier for timer.
  final ValueNotifier<int> _timerCount = ValueNotifier<int>(60);

  /// Timer.
  late final Timer _timer;

  @override
  void initState() {
    _startTimer();

    /// End the game if player close or pause the app.
    _appLifecycleListener = AppLifecycleListener(
      onPause: () =>
          context.readGameSessionBloc.add(GameSessionUserSurrendered()),
    );
    super.initState();
  }

  /// Starts timer.
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timerCount.value = _timerCount.value - 1;
    });
  }

  /// Updates _timesCount value.
  void _restartTimerCount() {
    _timerCount.value = 60;
  }

  /// Stops timer.
  void _cancelTimer() {
    _timer.cancel();
  }

  @override
  void dispose() {
    _appLifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.readAuthBloc.state.user.id;
    final locale = context.l10n;
    return BlocProvider(
      create: (context) => GameSessionBloc(
        gameSessionRepository:
            RepositoryProvider.of<IGameSessionRepository>(context),
        userId: userId,
        gameSessionId: widget.gameSessionId,
      ),
      child: Scaffold(
        body: BlocListener<GameSessionBloc, GameSessionState>(
          listener: (context, state) {
            if (state is GameSessionComplete) {
              _cancelTimer();
            }
          },
          child: SafeArea(
            child: Stack(
              children: [
                BlocBuilder<GameSessionBloc, GameSessionState>(
                  builder: (context, state) {
                    if (state.gameSession.gameBoards.length != 2) {
                      return Center(
                        child: Text(locale.waitingForPlayer),
                      );
                    } else {
                      _restartTimerCount();
                      final userGameBoard = state.gameSession.gameBoards
                          .firstWhere(
                              (gameBoard) => gameBoard.userId == userId);
                      final enemyGameBoard = state.gameSession.gameBoards
                          .firstWhere(
                              (gameBoard) => gameBoard.userId != userId);

                      final isUserTurn =
                          state.gameSession.currentTurnUserId == userId;
                      return Stack(
                        children: [
                          AbsorbPointer(
                            absorbing: state is GameSessionComplete,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 50),
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                final boardHeight =
                                    (constraints.maxHeight * 0.85) / 2;
                                return Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AbsorbPointer(
                                        absorbing: true,
                                        child: GameBoardWidget(
                                            height: boardHeight,
                                            width: boardHeight,
                                            gameBoard: userGameBoard),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Column(
                                          children: [
                                            Text(
                                              isUserTurn
                                                  ? locale.yourTurn
                                                  : locale.enemyTurn,
                                            ),
                                            const SizedBox(height: 10),
                                            TimerWidget(
                                              timerCount: _timerCount,
                                              isUserTurn: isUserTurn,
                                            ),
                                          ],
                                        ),
                                      ),
                                      AbsorbPointer(
                                        absorbing: !isUserTurn,
                                        child: GameBoardWidget(
                                          height: boardHeight,
                                          width: boardHeight,
                                          gameBoard: enemyGameBoard,
                                          isEnemyBoard: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                          if (state is GameSessionComplete)
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 40,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(state.isUserWon
                                            ? 'You won'
                                            : 'You lost'),
                                        const SizedBox(height: 40),
                                        ElevatedButton(
                                          onPressed: () => context.router.pop(),
                                          child:
                                              const Text('Leave the session'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    }
                  },
                ),
                Positioned(
                  top: 10,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      context.readGameSessionBloc
                          .add(GameSessionUserSurrendered());
                      context.router.pop();
                    },
                    child: const SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
