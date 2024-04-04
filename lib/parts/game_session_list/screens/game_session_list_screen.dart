part of '../game_session_list_part.dart';

@RoutePage()
class GameSessionListScreen extends StatelessWidget {
  const GameSessionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameSessionListBloc(
        gameSessionRepository: FbDbGameSessionRepository(
          fbDbDataProvider: FbDbGameSessionDataProvider(
            gameSessionId: '',
            db: FirebaseDatabase.instance,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Choose your opponent'),
        ),
        body: BlocBuilder<GameSessionListBloc, GameSessionListState>(
          builder: (context, state) {
            return switch (state) {
              GameSessionListInit init when init.gameSessionList.isEmpty =>
                const Center(
                  child: Text('List is empty'),
                ),
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
              // GameSessionListSuccess successState => ListView.builder(
              //     itemBuilder: (context, index) => Text(
              //         successState.list[index].gameBoards.first.userNickname),
              //     itemCount: successState.list.length,
              //   ),
              GameSessionListSuccess successState => Column(
                  children: [
                    ...successState.gameSessionList
                        .map((e) => Text(e.gameBoards.first.userNickname))
                  ],
                ),
            };
          },
        ),
      ),
    );
  }
}
