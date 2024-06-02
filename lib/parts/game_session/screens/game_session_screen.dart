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

  VoidCallback? _surrendUser;
  VoidCallback? _removeSession;

  @override
  void initState() {
    _startTimer();

    /// End the game if player close or pause
    /// the app during active session with another player.
    _appLifecycleListener = AppLifecycleListener(
      onInactive: () => _onSessionClose(),
    );
    super.initState();
  }

  /// On session close function.
  void _onSessionClose() {
    if (_surrendUser case final func?) {
      func();
    } else if (_removeSession case final removeFunc?) {
      removeFunc();
    }
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

  void _goToHome() {
    context.router.popUntilRouteWithName(HomeRoute.name);
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.readAuthBloc.state.user.id;
    final locale = context.l10n;
    return BlocProvider(
      create: (context) => GameSessionBloc(
        gameSessionRepository:
            RepositoryProvider.of<IGameSessionRepository>(context),
        profileRepository: RepositoryProvider.of<IProfileRepository>(context),
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
                    _removeSession ??= () =>
                        context.readGameSessionBloc.add(GameSessionRemove());
                    return Stack(
                      children: [
                        switch (state) {
                          GameSessionFailure _ => Center(
                              child: Text(parseErrorType(state.error!)
                                  .toLocalizedMessage(locale)),
                            ),
                          GameSessionState st
                              when st.gameSession.isWaitingForPlayer =>
                            Center(
                              child: Text(locale.waitingForPlayer),
                            ),
                          _ => Builder(
                              builder: (context) {
                                _restartTimerCount();
                                _surrendUser ??= () => context
                                    .readGameSessionBloc
                                    .add(GameSessionUserSurrendered());
                                final userGameBoard = state
                                    .gameSession.gameBoards
                                    .firstWhere((gameBoard) =>
                                        gameBoard.userId == userId);
                                final enemyGameBoard = state
                                    .gameSession.gameBoards
                                    .firstWhere((gameBoard) =>
                                        gameBoard.userId != userId);

                                final isUserTurn =
                                    state.gameSession.currentTurnUserId ==
                                        userId;

                                return Stack(
                                  children: [
                                    AbsorbPointer(
                                      absorbing: state is GameSessionComplete,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 50),
                                        child: LayoutBuilder(
                                            builder: (context, constraints) {
                                          final boardHeight =
                                              (constraints.maxHeight * 0.85) /
                                                  2;
                                          return Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AbsorbPointer(
                                                  absorbing: true,
                                                  child: GameBoardWidget(
                                                      height: boardHeight,
                                                      width: boardHeight,
                                                      gameBoard: userGameBoard),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 20),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        isUserTurn
                                                            ? locale.yourTurn
                                                            : locale.enemyTurn,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
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
                                      Builder(builder: (context) {
                                        if (state.isUserWon) {
                                          context.readGameSessionBloc.add(
                                              UserProfileStatisticUpdated());
                                        }
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 40,
                                                  vertical: 40,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(state.isUserWon
                                                        ? 'You won'
                                                        : 'You lost'),
                                                    const SizedBox(height: 40),
                                                    ElevatedButton(
                                                      onPressed: () =>
                                                          _goToHome(),
                                                      child: const Text(
                                                          'Leave the session'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                  ],
                                );
                              },
                            ),
                        },
                        AbsorbPointer(
                          absorbing: state is GameSessionComplete,
                          child: Positioned(
                            top: 10,
                            left: 20,
                            child: GestureDetector(
                              onTap: () {
                                _onSessionClose();
                                _goToHome();
                              },
                              child: const SizedBox(
                                width: 30,
                                height: 30,
                                child: Icon(Icons.close),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
