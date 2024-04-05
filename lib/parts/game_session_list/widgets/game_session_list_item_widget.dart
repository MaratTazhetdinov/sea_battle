part of '../game_session_list_part.dart';

class GameSessionListItemWidget extends StatelessWidget {
  final Profile profile;
  final String sessionId;

  const GameSessionListItemWidget({
    super.key,
    required this.profile,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return GestureDetector(
      onTap: () {
        /// to ships alignment screen
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: colors.firstTextColor,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: ListTile(
          title: Text(profile.nickname),
          subtitle:
              Text('Statistics - wins: ${profile.win} / loss: ${profile.loss}'),
        ),
      ),
    );
  }
}
