part of '../game_session_part.dart';

@RoutePage()
class GameSessionScreen extends StatefulWidget {
  const GameSessionScreen({super.key});

  @override
  State<GameSessionScreen> createState() => _GameSessionScreenState();
}

class _GameSessionScreenState extends State<GameSessionScreen> {
  @override
  Widget build(BuildContext context) {
    // final userId = context.readAuthBloc.state.user.id;
    const userId = 'newUser';
    return RepositoryProvider<IGameSessionRepository>(
      create: (context) => FbDbGameSessionRepository(
        fbDbDataProvider: FbDbGameSessionDataProvider(
          gameSessionId: 'anotherRandomKey',
          db: FirebaseDatabase.instance,
        ),
      ),
      child: BlocProvider(
        create: (context) => GameSessionBloc(
          gameSessionRepository:
              RepositoryProvider.of<IGameSessionRepository>(context),
          userId: userId,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Game Session'),
          ),
          body: Center(
            child: BlocBuilder<GameSessionBloc, GameSessionState>(
              builder: (context, state) {
                if (state.gameSession.gameBoards.isEmpty) {
                  return const Center(
                    child: Text('Loading'),
                  );
                }
                // final userBoard = state.gameSession.gameBoards
                //     .firstWhere((gameBoard) => gameBoard.userId == userId);
                // final enemyBoard = state.gameSession.gameBoards
                //     .firstWhere((gameBoard) => gameBoard.userId != userId);
                return Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '',
                              ),
                            ),
                          );
                        },
                        itemCount: 100,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 300,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => context.readGameSessionBloc
                                .add(GameSessionUserShot(index)),
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '',
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: 100,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
