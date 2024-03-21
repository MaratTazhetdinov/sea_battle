part of '../game_session_part.dart';

@RoutePage()
class GameSessionScreen extends StatefulWidget {
  const GameSessionScreen({super.key});

  @override
  State<GameSessionScreen> createState() => _GameSessionScreenState();
}

class _GameSessionScreenState extends State<GameSessionScreen> {
  final dataProvider = FbDbGameSessionDataProvider(
    gameSessionId: 'anotherRandomKey',
    db: FirebaseDatabase.instance,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Session'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dataProvider.finishShipsAlignment(
            userId: 'newUser',
            cells: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
          );
        },
      ),
      body: StreamBuilder<DtoGameSession>(
        stream: dataProvider.gameSession,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final firstBoard = snapshot.data!.dtoGameBoards.first;
            final cells = firstBoard.cells;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      dataProvider.shoot(
                        userId: firstBoard.userId,
                        cellIndex: index,
                        cellState: 7,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          cells[index].toString(),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: cells.length,
              ),
            );
          } else {
            return const Center(
              child: Text('Loading'),
            );
          }
        },
      ),
    );
  }
}
