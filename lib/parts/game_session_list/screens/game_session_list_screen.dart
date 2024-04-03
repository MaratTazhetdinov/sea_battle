part of '../game_session_list_part.dart';

class GameSessionListScreen extends StatelessWidget {
  const GameSessionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose your opponent'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Container();
      }),
    );
  }
}
