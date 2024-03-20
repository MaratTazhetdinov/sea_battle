part of '../game_session_part.dart';

@RoutePage()
class GameSessionScreen extends StatefulWidget {
  const GameSessionScreen({super.key});

  @override
  State<GameSessionScreen> createState() => _GameSessionScreenState();
}

class _GameSessionScreenState extends State<GameSessionScreen> {
  String value = '';
  final dataProvider = FirebaseDatabaseGameSessionDataProvider(
    gameSessionId: 'anotherRandomKey',
    db: FirebaseDatabase.instance,
  );
  @override
  Widget build(BuildContext context) {
    // final dataProvider = FirebaseDatabaseGameSessionDataProvider(
    //   gameSessionId: '',
    //   db: FirebaseDatabase.instance,
    // );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Session'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dataProvider.shoot();
        },
      ),
      body: Center(
        child: StreamBuilder<DtoGameSession>(
            stream: dataProvider.gameSession,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error?.toString() ?? '');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('loading');
              }
              if (snapshot.hasData) {
                return Text(
                  snapshot.data?.gameBoards.first.userId ?? '',
                );
              }
              return const Text('Nothing happend');
            }),
      ),
    );
  }
}
