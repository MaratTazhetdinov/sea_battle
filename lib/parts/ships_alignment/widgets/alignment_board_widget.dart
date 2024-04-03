part of '../ships_alignment_part.dart';

class AlignmentBoardWidget extends StatefulWidget {
  final Size boardSize;
  final ValueNotifier<DraggableShip> draggableShip;
  final ValueNotifier<List<int>> potentialIndexes;
  final Function(DragStartDetails, Ship) onPanStart;
  final Function(DragUpdateDetails) onPanUpdate;
  final Function(DragEndDetails, BuildContext) onPanEnd;

  const AlignmentBoardWidget({
    super.key,
    required this.boardSize,
    required this.draggableShip,
    required this.potentialIndexes,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
  });

  @override
  State<AlignmentBoardWidget> createState() => _AlignmentBoardWidgetState();
}

class _AlignmentBoardWidgetState extends State<AlignmentBoardWidget> {
  late final _boardSize = widget.boardSize;
  late final _draggableShip = widget.draggableShip;
  late final _potentialIndexes = widget.potentialIndexes;

  Offset? _boardOffset;
  int _currentDragTargetIndex = -1;
  late GameBoard _board;

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((duration) {
    //   Future.delayed(duration).then((_) {
    //     RenderBox? renderBox =
    //         key.currentContext?.findRenderObject() as RenderBox?;
    //     if (renderBox case final box?) {
    //       _boardOffset = box.localToGlobal(Offset.zero);
    //       print(_boardOffset);
    //     }
    //   });
    // });
    _boardOffset = const Offset(40.0, 123.0);

    _draggableShip.addListener(() {
      _calculatePotentialIndexes(_draggableShip.value);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _calculatePotentialIndexes(DraggableShip draggableShip) {
    if (_boardOffset case final boardOffset?) {
      final minX = boardOffset.dx;
      final maxX = boardOffset.dx + _boardSize.width;
      final minY = boardOffset.dy;
      final maxY = boardOffset.dy + _boardSize.height;
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
          _potentialIndexes.value = _board.checkPossibleAlignment(
              index: index, ship: draggableShip.ship);
        }
      } else {
        _currentDragTargetIndex = -1;
        _potentialIndexes.value = [];
      }
    }
  }

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
    return BlocBuilder<ShipsAlignmentBloc, ShipsAlignmentState>(
      builder: (context, state) {
        _board = state.board;
        final occupiedIndexes = _board.findOccupiedIndexes();
        return GestureDetector(
          onPanStart: (details) {
            final index = _calculateIndexFromOffset(
              minX: _boardOffset!.dx,
              maxX: _boardOffset!.dx + _boardSize.width,
              positionX: details.globalPosition.dx,
              minY: _boardOffset!.dy,
              maxY: _boardOffset!.dy + _boardSize.width,
              positionY: details.globalPosition.dy,
            );
            final isCellOccupied = occupiedIndexes.contains(index);

            if (isCellOccupied) {
              final ship = _board.detectShipByIndex(index);
              widget.onPanStart(details, ship);
              context.readShipAlignmentBloc.add(ShipRemovedByIndex(index));
            }
          },
          onPanUpdate: (details) {
            if (widget.draggableShip.value.offset != Offset.zero) {
              widget.onPanUpdate(details);
            }
          },
          onPanEnd: (details) => widget.onPanEnd(details, context),
          child: Container(
            height: _boardSize.height,
            width: _boardSize.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
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
                                ? Colors.blue
                                : list.contains(index)
                                    ? Colors.amber
                                    : Colors.transparent,
                            border: Border.all(
                              color: Colors.black,
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
