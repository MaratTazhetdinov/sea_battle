part of '../home_part.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.l10n;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.router.push(ShipsAlignmentRoute());
                },
                child: Text(locale.createGame),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    context.router.push(const GameSessionListRoute());
                  },
                  child: Text(locale.joinGame),
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
      ),
    );
  }
}
