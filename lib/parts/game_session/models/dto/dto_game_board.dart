part of '../../game_session_part.dart';

/// [DtoGameBoard].
class DtoGameBoard {
  /// User id.
  final String userId;

  /// List of cells with int representation for their states.
  final List<int> cells;

  const DtoGameBoard({
    required this.userId,
    required this.cells,
  });
}
