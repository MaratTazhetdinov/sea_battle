part of '../game_session_part.dart';

/// Game Board widget.
class GameBoardWidget extends StatelessWidget {
  /// Game Board height.
  final double height;

  /// Game Board width.
  final double width;

  /// [GameBoard].
  final GameBoard gameBoard;

  /// Is enemy board.
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
                      ? switch (cellStates[index]) {
                          CellState.destroyed => Colors.blue,
                          _ => Colors.transparent,
                        }
                      : switch (cellStates[index]) {
                          CellState.occupied ||
                          CellState.destroyed =>
                            Colors.blue,
                          _ => Colors.transparent,
                        },
                  border: Border.all(
                    color: colors.firstTextColor,
                    width: 0.5,
                  ),
                ),
                child: switch (cellStates[index]) {
                  CellState.destroyed => const AnimatedFireWidget(),
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

class AnimatedFireWidget extends StatefulWidget {
  const AnimatedFireWidget({super.key});

  @override
  State<AnimatedFireWidget> createState() => _AnimatedFireWidgetState();
}

class _AnimatedFireWidgetState extends State<AnimatedFireWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 0.85),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.85, end: 1),
          weight: 50,
        ),
      ],
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.forward(from: 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Transform.scale(
          scale: _animation.value,
          child: Image.asset(Assets.images.fire.path),
        );
      },
    );
  }
}
