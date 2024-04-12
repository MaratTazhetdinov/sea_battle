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
    return BlocProvider(
      create: (context) => GameSessionBloc(
        gameSessionRepository:
            RepositoryProvider.of<IGameSessionRepository>(context),
        userId: userId,
        gameSessionId: widget.gameSessionId,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Game Session'),
        ),
        body: Center(
          child: BlocBuilder<GameSessionBloc, GameSessionState>(
            builder: (context, state) {
              if (state.gameSession.gameBoards.length != 2) {
                return const Center(
                  child: Text('Waiting For Player'),
                );
              } else {
                final playerGameBoard = state.gameSession.gameBoards
                    .firstWhere((gameBoard) => gameBoard.userId == userId);
                final enemyGameBoard = state.gameSession.gameBoards
                    .firstWhere((gameBoard) => gameBoard.userId != userId);
                return Column(
                  children: [
                    GameBoardWidget(
                        height: 300, width: 300, gameBoard: playerGameBoard),
                    const SizedBox(height: 40),
                    GameBoardWidget(
                      height: 300,
                      width: 300,
                      gameBoard: enemyGameBoard,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
