part of '../../game_session_part.dart';

class DtoGameBoard {
  final String userId;
  final String userNickname;
  final List<int> cells;

  const DtoGameBoard({
    required this.userId,
    required this.userNickname,
    required this.cells,
  });
}
