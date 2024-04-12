part of '../game_session_list_part.dart';

@RoutePage()
class GameSessionListScreen extends StatelessWidget {
  const GameSessionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.l10n;
    return PopScope(
      onPopInvoked: (didPop) {
        print(didPop);
      },
      child: BlocProvider(
        create: (context) => GameSessionListBloc(
          gameSessionRepository:
              RepositoryProvider.of<IGameSessionRepository>(context),
          profileRepository: RepositoryProvider.of<IProfileRepository>(context),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(locale.chooseYourOpponent),
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
                          child: Text(locale.reload),
                        ),
                      ],
                    ),
                  ),
                GameSessionListSuccess successState
                    when successState.list.isEmpty =>
                  Center(
                    child: Text(locale.noActiveSessions),
                  ),
                GameSessionListSuccess successState => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final profile = successState.profiles.firstWhere(
                            (profile) =>
                                profile.id ==
                                successState
                                    .list[index].gameBoards.first.userId);
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: 20,
                            top: index == 0 ? 20 : 0,
                          ),
                          child: GameSessionListItemWidget(
                            profile: profile,
                            gameSessionId:
                                successState.list[index].gameSessionId,
                          ),
                        );
                      },
                      itemCount: successState.gameSessionList.length,
                    ),
                  ),
              };
            },
          ),
        ),
      ),
    );
  }
}
