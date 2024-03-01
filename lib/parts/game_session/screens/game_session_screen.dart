part of '../game_session_part.dart';

@RoutePage()
class GameSessionScreen extends StatefulWidget {
  const GameSessionScreen({super.key});

  @override
  State<GameSessionScreen> createState() => _GameSessionScreenState();
}

class _GameSessionScreenState extends State<GameSessionScreen> {
  String value = '';
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
        child: StreamBuilder<DatabaseEvent>(
            stream: FirebaseDatabase.instance
                .ref('games')
                .child('123456789')
                .onValue,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('loading');
              }
              if (snapshot.hasData) {
                return Text(snapshot.data!.snapshot.value.toString());
              }
              return Text('Nothing happend');
            }),
      ),
    );
  }
}
