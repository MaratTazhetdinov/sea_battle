part of '../ships_alignment_part.dart';

class AlignmentBoardWidget extends StatefulWidget {
  final Size boardSize;
  final ValueNotifier<DraggableShip> draggableShip;
  final ValueNotifier<List<int>> potentialIndexes;
  final Board board;

  const AlignmentBoardWidget({
    super.key,
    required this.boardSize,
    required this.draggableShip,
    required this.potentialIndexes,
    required this.board,
  });

  @override
  State<AlignmentBoardWidget> createState() => _AlignmentBoardWidgetState();
}

class _AlignmentBoardWidgetState extends State<AlignmentBoardWidget> {
  late final _boardSize = widget.boardSize;
  late final _draggableShip = widget.draggableShip;
  late final _potentialIndexes = widget.potentialIndexes;
  late final _board = widget.board;

  Offset? _boardOffset;
  int _currentDragTargetIndex = -1;

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
      print(_draggableShip.value.offset);
      _calculateDragTargetIndex(_draggableShip.value);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _calculateDragTargetIndex(DraggableShip draggableShip) {
    if (_boardOffset case final boardOffset?) {
      if ((draggableShip.offset.dx >= boardOffset.dx &&
              draggableShip.offset.dx <= boardOffset.dx + _boardSize.width) &&
          (draggableShip.offset.dy >= boardOffset.dy &&
              draggableShip.offset.dy <= boardOffset.dy + _boardSize.height)) {
        final x = _calculateIndexFromOffset(boardOffset.dx,
            boardOffset.dx + _boardSize.width, draggableShip.offset.dx);
        final y = _calculateIndexFromOffset(boardOffset.dy,
                boardOffset.dy + _boardSize.width, draggableShip.offset.dy) *
            10;
        final index = x + y;
        if (_currentDragTargetIndex != index) {
          _currentDragTargetIndex = index;
          _potentialIndexes.value = _board.checkShipAlignment(
              index: index, ship: draggableShip.ship!);
        }
      } else {
        _currentDragTargetIndex = 0;
        _potentialIndexes.value = [];
      }
    }
  }

  int _calculateIndexFromOffset(double min, double max, double position) {
    final cell = (max - min) / 10;
    final List<double> fractions =
        List.generate(10, (index) => (index + 1) * cell + min);
    for (int i = 0; i < fractions.length; i++) {
      if (position <= fractions[i]) {
        return i;
      }
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    /// Make all widget draggable
    return GestureDetector(
      onPanStart: (details) {
        final x = _calculateIndexFromOffset(_boardOffset!.dx,
            _boardOffset!.dx + _boardSize.width, details.globalPosition.dx);
        final y = _calculateIndexFromOffset(
                _boardOffset!.dy,
                _boardOffset!.dy + _boardSize.width,
                details.globalPosition.dy) *
            10;
        final index = x + y;
        Ship? ship;
        if (_board.isOccupiedIndex(index)) {
          ship = _board.detectShipByIndex(index);
        }
        if (ship != null) {
          _draggableShip.value = DraggableShip(
              ship: ship,
              offset:
                  Offset(details.globalPosition.dx, details.globalPosition.dy));
          _board.removeShipByIndex(index);
        }
      },
      onPanUpdate: (details) {
        final x = _calculateIndexFromOffset(_boardOffset!.dx,
            _boardOffset!.dx + _boardSize.width, details.globalPosition.dx);
        final y = _calculateIndexFromOffset(
                _boardOffset!.dy,
                _boardOffset!.dy + _boardSize.width,
                details.globalPosition.dy) *
            10;
        final index = x + y;
        final ship = _draggableShip.value.ship;
        _potentialIndexes.value =
            _board.checkShipAlignment(index: index, ship: ship!);
        _draggableShip.value = DraggableShip(
            ship: ship,
            offset:
                Offset(details.globalPosition.dx, details.globalPosition.dy));
      },
      onPanEnd: (details) {
        _board.addShipToBoard(
            _potentialIndexes.value, _draggableShip.value.ship!);
        _potentialIndexes.value = [];
        _draggableShip.value = DraggableShip.empty();
      },
      child: Container(
        height: _boardSize.height,
        width: _boardSize.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        child: Stack(
          children: [
            ValueListenableBuilder(
                valueListenable: _potentialIndexes,
                builder: (context, list, _) {
                  final occupiedIndexes = _board.occupiedIndexes;
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
            ValueListenableBuilder(
                valueListenable: _draggableShip,
                builder: (context, value, _) {
                  if (value.offset != Offset.zero) {
                    Ship? ship = value.ship;
                    return Transform.translate(
                      offset: value.offset,
                      child: ship != null
                          ? ShipWidget(
                              shipType: ship.shipType,
                              axis: ship.shipAxis,
                              cellHeight: 50)
                          : Container(
                              height: 50,
                              width: 50,
                              color: Colors.red,
                            ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
