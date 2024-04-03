part of '../home_part.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home'),
            ElevatedButton(
              onPressed: () {
                context.router.push(const GameSessionRoute());
              },
              child: const Text('Start Game'),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  context.router.push(const ShipsAlignmentRoute());
                },
                child: const Text('Ships Alignment'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.readAuthBloc.add(AuthLoggedOut());
              },
              child: const Text('LogOut'),
            ),
          ],
        ),
      ),
    );
  }
}
