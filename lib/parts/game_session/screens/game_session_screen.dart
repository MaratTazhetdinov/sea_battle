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
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Game Session'),
          ),
          body: Center(
            child: BlocBuilder<GameSessionBloc, GameSessionState>(
              builder: (context, state) {
                if (state is GameSessionLoaded) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            state.gameSession.gameBoards.first.cells[index]
                                .toString(),
                          ),
                        ),
                      );
                    },
                    itemCount: state.gameSession.gameBoards.first.cells.length,
                  );
                } else {
                  return const Center(
                    child: Text('Loading'),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
