part of '../game_session_list_part.dart';

@RoutePage()
class GameSessionListScreen extends StatelessWidget {
  const GameSessionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameSessionListBloc(
        gameSessionRepository:
            RepositoryProvider.of<IGameSessionRepository>(context),
        profileRepository: RepositoryProvider.of<IProfileRepository>(context),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Choose your opponent'),
        ),
        body: BlocBuilder<GameSessionListBloc, GameSessionListState>(
          builder: (context, state) {
            return switch (state) {
              GameSessionListInit _ => const Center(
                  child: CircularProgressIndicator(),
                ),
              GameSessionListFailure errorState => Center(
                  child: Column(
                    children: [
                      Text(errorState.error.toString()),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Reload'),
                      ),
                    ],
                  ),
                ),
              GameSessionListSuccess successState
                  when successState.list.isEmpty =>
                const Center(
                  child: Text('List is empty'),
                ),
              GameSessionListSuccess successState => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ...successState.gameSessionList.map((e) {
                        final profile = successState.profiles.firstWhere(
                            (profile) =>
                                profile.id == e.gameBoards.first.userId);
                        return GameSessionListItemWidget(
                          profile: profile,
                          sessionId: e.gameSessionId,
                        );
                      }),
                    ],
                  ),
                ),
            };
          },
        ),
      ),
    );
  }
}
