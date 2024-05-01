part of '../ships_alignment_part.dart';

/// Alignment game board widget.
class AlignmentGameBoardWidget extends StatefulWidget {
  /// Game board size.
  final Size gameBoardSize;

  /// Value notifier of [DraggableShip].
  final ValueNotifier<DraggableShip> draggableShip;

  /// Value notifier of list of potentialIndexes for [DraggableShip] on [GameBoard].
  final ValueNotifier<List<int>> possibleIndexes;

  /// OnPanStart function.
  final Function(DragStartDetails, Ship) onPanStart;

  /// OnPanUpdate function.
  final Function(DragUpdateDetails) onPanUpdate;

  /// OnPanEnd function.
  final Function(DragEndDetails, BuildContext) onPanEnd;

  const AlignmentGameBoardWidget({
    super.key,
    required this.gameBoardSize,
    required this.draggableShip,
    required this.possibleIndexes,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
  });

  @override
  State<AlignmentGameBoardWidget> createState() =>
      _AlignmentGameBoardWidgetState();
}

class _AlignmentGameBoardWidgetState extends State<AlignmentGameBoardWidget> {
  late final _gameBoardSize = widget.gameBoardSize;
  late final _draggableShip = widget.draggableShip;
  late final _potentialIndexes = widget.possibleIndexes;

  /// Global offset of [AlignmentGameBoardWidget].
  Offset? _gameBoardOffset;

  /// Current index of [GameBoard] according to [DraggableShip] offset.
  int _currentDragTargetIndex = -1;
  late GameBoard _gameBoard;
  final _key = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300)).then((_) {
        RenderBox? renderBox =
            _key.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox case final box?) {
          _gameBoardOffset = box.localToGlobal(Offset.zero);
        }
      });
    });

    _draggableShip.addListener(() {
      _calculatePotentialIndexes(_draggableShip.value);
    });
    super.initState();
  }

  @override
  void dispose() {
    _draggableShip.removeListener(() {});
    super.dispose();
  }

  /// Calculates potential indexes on [GameBoard] for [DraggableShip].
  void _calculatePotentialIndexes(DraggableShip draggableShip) {
    if (_gameBoardOffset case final boardOffset?) {
      final minX = boardOffset.dx;
      final maxX = boardOffset.dx + _gameBoardSize.width;
      final minY = boardOffset.dy;
      final maxY = boardOffset.dy + _gameBoardSize.height;
      final positionX = draggableShip.offset.dx;
      final positionY = draggableShip.offset.dy;
      if ((positionX >= minX && positionX <= maxX) &&
          (positionY >= minY && positionY <= maxY)) {
        final index = _calculateIndexFromOffset(
          minX: minX,
          maxX: maxX,
          positionX: positionX,
          minY: minY,
          maxY: maxY,
          positionY: positionY,
        );

        if (_currentDragTargetIndex != index) {
          _currentDragTargetIndex = index;
          _potentialIndexes.value = ShipsAlignmentLogic.checkPossibleAlignment(
            index: index,
            ship: draggableShip.ship,
            cell: _gameBoard.cell,
          );
        }
      } else {
        _currentDragTargetIndex = -1;
        _potentialIndexes.value = [];
      }
    }
  }

  /// Calculates index on [GameBoard] according to [DraggableShip] offset.
  int _calculateIndexFromOffset({
    required double minX,
    required double maxX,
    required double positionX,
    required double minY,
    required double maxY,
    required double positionY,
  }) {
    final cell = (maxX - minX) / 10;
    int x = 0;
    int y = 0;
    final List<double> fractionsX =
        List.generate(10, (index) => (index + 1) * cell + minX);
    final List<double> fractionsY =
        List.generate(10, (index) => (index + 1) * cell + minY);
    for (int i = 0; i < fractionsX.length; i++) {
      if (positionX <= fractionsX[i]) {
        x = i;
        break;
      }
    }
    for (int i = 0; i < fractionsY.length; i++) {
      if (positionY <= fractionsY[i]) {
        y = i * 10;
        break;
      }
    }
    return x + y;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return BlocBuilder<ShipsAlignmentBloc, ShipsAlignmentState>(
      builder: (context, state) {
        _gameBoard = state.gameBoard;
        final occupiedIndexes = _gameBoard.cell.findOccupiedIndexes();
        return GestureDetector(
          onPanStart: (details) {
            final index = _calculateIndexFromOffset(
              minX: _gameBoardOffset!.dx,
              maxX: _gameBoardOffset!.dx + _gameBoardSize.width,
              positionX: details.globalPosition.dx,
              minY: _gameBoardOffset!.dy,
              maxY: _gameBoardOffset!.dy + _gameBoardSize.width,
              positionY: details.globalPosition.dy,
            );
            final isCellOccupied = occupiedIndexes.contains(index);

            if (isCellOccupied) {
              final shipIndexes =
                  _gameBoard.cell.detectShipIndexesByIndex(index);
              context.readShipAlignmentBloc
                  .add(ShipRemovedByIndexes(shipIndexes));
              widget.onPanStart(details, Ship.fromIndexes(shipIndexes));
            }
          },
          onPanUpdate: (details) {
            if (widget.draggableShip.value.offset != Offset.zero) {
              widget.onPanUpdate(details);
            }
          },
          onPanEnd: (details) => widget.onPanEnd(details, context),
          child: Container(
            key: _key,
            height: _gameBoardSize.height,
            width: _gameBoardSize.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: colors.firstTextColor,
                width: 0.5,
              ),
            ),
            child: ValueListenableBuilder(
                valueListenable: _potentialIndexes,
                builder: (context, list, _) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 10),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            color: occupiedIndexes.contains(index)
                                ? colors.alignedShipColor
                                : list.contains(index)
                                    ? colors.possibleShipAlignmentColor
                                    : colors.scaffoldBackgroundColor,
                            border: Border.all(
                              color: colors.firstTextColor,
                              width: 0.5,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: 100,
                  );
                }),
          ),
        );
      },
    );
  }
}
