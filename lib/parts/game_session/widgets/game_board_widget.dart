part of '../game_session_part.dart';

class GameBoardWidget extends StatelessWidget {
  final double height;
  final double width;
  final GameBoard gameBoard;

  const GameBoardWidget({
    super.key,
    required this.height,
    required this.width,
    required this.gameBoard,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final cellStates = gameBoard.cell.getCellsState();
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: colors.firstTextColor,
          width: 0.5,
        ),
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
        itemBuilder: (context, index) {
          return SizedBox(
            child: Container(
              decoration: BoxDecoration(
                color: switch (cellStates[index]) {
                  CellState.empty => colors.scaffoldBackgroundColor,
                  CellState.occupied => colors.alignedShipColor,
                  CellState.shooted => Colors.amber,
                  CellState.destroyed => Colors.red,
                },
                border: Border.all(
                  color: colors.firstTextColor,
                  width: 0.5,
                ),
              ),
            ),
          );
        },
        itemCount: 100,
      ),
    );
  }
}