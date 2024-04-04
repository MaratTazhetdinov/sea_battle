part of '../game_board_part.dart';

@props
@copyWith

/// [GameBoard].
class GameBoard extends Equatable {
  /// User id.
  final String userId;

  /// User nickname.
  final String userNickname;

  /// [GameBoardCell].
  final Cell cell;

  /// Creates [GameBoard].
  const GameBoard({
    required this.userId,
    required this.userNickname,
    required this.cell,
  });

  /// Factory constructor for creating [GameBoard] with given [userId] and [userNickname].
  factory GameBoard.create(
    String userId,
    String userNickname,
  ) {
    return GameBoard(
      userId: userId,
      userNickname: userNickname,
      cell: _createBoard(List.generate(100, (index) => 0)),
    );
  }

  /// Factory constructor for creating [GameBoard] from [DtoGameBoard].
  factory GameBoard.fromDto(DtoGameBoard dtoGameBoard) {
    return GameBoard(
      userId: dtoGameBoard.userId,
      userNickname: dtoGameBoard.userNickname,
      cell: _createBoard(dtoGameBoard.cells),
    );
  }

  /// Creates [GameBoardCell] with given [occupuidedIndexes].
  static Cell _createBoard(List<int> occupuidedIndexes) {
    final List<Cell> cells = List.generate(
        100,
        (index) => Cell(
              index: index,
              cellState: switch (occupuidedIndexes[index]) {
                1 => CellState.occupied,
                2 => CellState.destroyed,
                3 => CellState.shooted,
                _ => CellState.empty,
              },
            ));

    for (Cell cell in cells) {
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
