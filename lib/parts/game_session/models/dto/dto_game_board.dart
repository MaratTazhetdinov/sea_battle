part of '../../game_session_part.dart';

class DtoGameBoard {
  final String userId;
  final List<int> cells;

  const DtoGameBoard({
    required this.userId,
    required this.cells,
  });
}
