part of '../game_part.dart';

@RoutePage()
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10),
          itemBuilder: (context, index) {
            return Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.black,
              )),
            );
          },
          itemCount: 100,
        ),
      ),
    );
  }
}
