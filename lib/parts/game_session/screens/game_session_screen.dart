part of '../game_session_part.dart';

@RoutePage()
class GameSessionScreen extends StatefulWidget {
  final String gameSessionId;

  const GameSessionScreen({
    super.key,
    required this.gameSessionId,
  });

  @override
  State<GameSessionScreen> createState() => _GameSessionScreenState();
}

class _GameSessionScreenState extends State<GameSessionScreen> {
  @override
  Widget build(BuildContext context) {
    final userId = context.readAuthBloc.state.user.id;
    final locale = context.l10n;
    final colors = context.theme.colors;
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
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return Dialog(
                      clipBehavior: Clip.hardEdge,
                      backgroundColor: colors.transparent,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: colors.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.isUserWon ? 'You won' : 'You lost',
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () async {
                                    ctx.router.pop();
                                    context.router.popUntilRouteWithName(
                                        const HomeRoute().routeName);
                                  },
                                  child: const Text('Leave session'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
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
                      final userGameBoard = state.gameSession.gameBoards
                          .firstWhere(
                              (gameBoard) => gameBoard.userId == userId);
                      final enemyGameBoard = state.gameSession.gameBoards
                          .firstWhere(
                              (gameBoard) => gameBoard.userId != userId);

                      final isUserTurn =
                          state.gameSession.currentTurnUserId == userId;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: LayoutBuilder(builder: (context, constraints) {
                          final boardHeight =
                              (constraints.maxHeight * 0.85) / 2;
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AbsorbPointer(
                                  absorbing: true,
                                  child: GameBoardWidget(
                                      height: boardHeight,
                                      width: boardHeight,
                                      gameBoard: userGameBoard),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                    isUserTurn
                                        ? locale.yourTurn
                                        : locale.enemyTurn,
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
