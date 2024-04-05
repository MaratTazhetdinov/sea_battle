part of '../game_session_list_part.dart';

class GameSessionListItemWidget extends StatelessWidget {
  final UserModel user;
  final String sessionId;

  const GameSessionListItemWidget({
    super.key,
    required this.user,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.nickname),
      subtitle: const Text('Statistics'),
    );
  }
}
