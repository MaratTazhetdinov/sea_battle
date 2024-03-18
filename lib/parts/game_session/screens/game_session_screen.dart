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
    gameSessionId: 'randomKey',
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
      body: Center(
        child: StreamBuilder<DtoGameSession>(
            stream: dataProvider.gameSession,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('loading');
              }
              if (snapshot.hasData) {
                return Text(snapshot.data!.toString());
              }
              return const Text('Nothing happend');
            }),
      ),
    );
  }
}
