part of '../game_board_part.dart';

@props
@copyWith

/// [GameBoard].
class GameBoard extends Equatable {
  /// User id.
  final String userId;

  /// [GameBoardCell].
  final GameBoardCell gameBoardCell;

  /// Creates [GameBoard].
  const GameBoard({
    required this.userId,
    required this.gameBoardCell,
  });

  /// Factory constructor for creating [GameBoard] with given [userId] and [occupuidedIndexes].
  factory GameBoard.create(String userId,
      [List<int> occupuidedIndexes = const []]) {
    return GameBoard(
      userId: userId,
      gameBoardCell: _createBoard(occupuidedIndexes),
    );
  }

  /// Creates [GameBoardCell] with given [occupuidedIndexes].
  static GameBoardCell _createBoard(List<int> occupuidedIndexes) {
    final List<GameBoardCell> cells = List.generate(
        100,
        (index) => GameBoardCell(
              index: index,
              cellState: occupuidedIndexes.contains(index)
                  ? CellState.occupied
                  : CellState.empty,
            ));

    for (GameBoardCell cell in cells) {
      final index = cell.index;
      final copy = cells[index];
      copy.topCell = index - 10 >= 0 ? cells[index - 10] : null;
      copy.topRightCell =
          index - 10 >= 0 && index % 10 < 9 ? cells[index - 9] : null;
      copy.rightCell = index % 10 < 9 ? cells[index + 1] : null;
      copy.bottomRightCell =
          index + 10 <= 100 - 1 && index % 10 < 9 ? cells[index + 11] : null;
      copy.bottomCell = index + 10 <= 100 - 1 ? cells[index + 10] : null;
      copy.bottomLeftCell =
          index + 10 <= 100 - 1 && index % 10 > 0 ? cells[index + 9] : null;
      copy.leftCell = index % 10 > 0 ? cells[index - 1] : null;
      copy.topLeftCell =
          index - 10 >= 0 && index % 10 > 0 ? cells[index - 11] : null;
    }
    return cells.first;
  }

  @override
  List<Object?> get props => _$GameBoardProps(this);
}
