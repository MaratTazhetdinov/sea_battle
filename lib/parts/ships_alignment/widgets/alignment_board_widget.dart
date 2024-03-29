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

    _draggableShip
        .addListener(() => _calculateDragTargetIndex(_draggableShip.value));
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
          _potentialIndexes.value =
              _board.addShipToBoard(index: index, ship: draggableShip.ship!);
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
    return Container(
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10),
              itemBuilder: (context, index) {
                final isOcuppied = _board.isOccupied(index);
                if (isOcuppied) {
                  final ship = _board.getShipByIndex(index);
                  return Draggable(
                    feedback: ShipWidget(
                      axis: Axis.vertical,
                      shipType: ship.shipType,
                      cellHeight: 40,
                    ),
                    child: SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                    onDragStarted: () {
                      _board.removeShipByIndex(index);
                    },
                    onDragUpdate: (details) =>
                        _draggableShip.value = DraggableShip(
                      ship: ship,
                      offset: details.globalPosition,
                    ),
                    onDragEnd: (_) {
                      if (_potentialIndexes.value.isNotEmpty) {
                        /// add ship to board
                        print('added');
                        _board.addShip2(_potentialIndexes.value, ship);
                        _potentialIndexes.value = [];
                      }
                      _draggableShip.value = DraggableShip.empty();
                    },
                  );
                } else {
                  return SizedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        color: list.contains(index)
                            ? Colors.amber
                            : Colors.transparent,
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                    ),
                  );
                }
              },
              itemCount: 100,
            );
          }),
    );
  }
}
