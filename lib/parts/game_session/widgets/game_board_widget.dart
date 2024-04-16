part of '../game_session_part.dart';

class GameBoardWidget extends StatelessWidget {
  final double height;
  final double width;
  final GameBoard gameBoard;
  final bool isEnemyBoard;

  const GameBoardWidget({
    super.key,
    required this.height,
    required this.width,
    required this.gameBoard,
    this.isEnemyBoard = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final cellStates = gameBoard.cell.getCellsState();
    if (cellStates.where((state) => state == CellState.destroyed).length ==
        20) {
      context.readGameSessionBloc.add(GameSessionCompleted(isEnemyBoard));
    }
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
          return GestureDetector(
            onTap: () {
              context.readGameSessionBloc.add(GameSessionUserShot(index));
            },
            child: SizedBox(
              child: Container(
                decoration: BoxDecoration(
                  color: isEnemyBoard
                      ? Colors.transparent
                      : switch (cellStates[index]) {
                          CellState.occupied => Colors.blue,
                          _ => Colors.transparent,
                        },
                  border: Border.all(
                    color: colors.firstTextColor,
                    width: 0.5,
                  ),
                ),
                child: switch (cellStates[index]) {
                  CellState.destroyed => Image.asset(Assets.images.fire.path),
                  CellState.shot => Image.asset(Assets.images.splash.path),
                  _ => null,
                },
              ),
            ),
          );
        },
        itemCount: 100,
      ),
    );
  }
}
