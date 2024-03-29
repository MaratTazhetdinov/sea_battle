part of '../ships_alignment_part.dart';

enum ShipType {
  one(1),
  two(2),
  three(3),
  four(4);

  final int size;

  const ShipType(this.size);
}

class ShipPickerWidget extends StatefulWidget {
  final double widgetHeight;
  final double defaultCellHeight;
  final double draggedCellHeight;

  final ShipType shipType;
  final ValueNotifier<Map<ShipType, int>> shipCounter;
  final ValueNotifier<DraggableShip> draggableShip;
  final ValueNotifier<List<int>> potentialIndexes;
  final Board board;
  const ShipPickerWidget({
    super.key,
    required this.widgetHeight,
    required this.defaultCellHeight,
    required this.draggedCellHeight,
    required this.shipType,
    required this.shipCounter,
    required this.draggableShip,
    required this.potentialIndexes,
    required this.board,
  });

  @override
  State<ShipPickerWidget> createState() => _ShipPickerWidgetState();
}

class _ShipPickerWidgetState extends State<ShipPickerWidget> {
  late final _draggableShip = widget.draggableShip;
  late final _potentialIndexes = widget.potentialIndexes;
  late final _board = widget.board;
  @override
  Widget build(BuildContext context) {
    final shipType = widget.shipType;
    final defaultCellHeight = widget.defaultCellHeight;
    final draggedCellHeight = widget.draggedCellHeight;
    return SizedBox(
      height: widget.widgetHeight,
      child: ValueListenableBuilder(
        valueListenable: widget.shipCounter,
        builder: (context, value, _) {
          final count = value[shipType] ?? 0;
          return AbsorbPointer(
            absorbing: count == 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Draggable(
                        feedback: ShipWidget(
                          axis: Axis.vertical,
                          shipType: shipType,
                          cellHeight: draggedCellHeight,
                        ),
                        child: ShipWidget(
                          axis: Axis.vertical,
                          shipType: shipType,
                          cellHeight: defaultCellHeight,
                        ),
                        onDragUpdate: (details) =>
                            _draggableShip.value = DraggableShip(
                              ship: Ship(
                                shipType: shipType,
                                shipAxis: Axis.vertical,
                              ),
                              offset: details.globalPosition,
                            ),
                        onDragEnd: (_) {
                          if (_potentialIndexes.value.isNotEmpty) {
                            /// add ship to board
                            print('added');
                            final map = widget.shipCounter.value;
                            int count = map[shipType] ?? 0;
                            map[shipType] = count - 1;
                            widget.shipCounter.value = map;
                            _board.addShipToBoard(
                                _potentialIndexes.value,
                                Ship(
                                  shipType: shipType,
                                  shipAxis: Axis.vertical,
                                ));
                            _potentialIndexes.value = [];
                          }
                          _draggableShip.value = DraggableShip.empty();
                        }),
                    if (shipType != ShipType.one)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('or'),
                      ),
                    if (shipType != ShipType.one)
                      Draggable(
                        feedback: ShipWidget(
                          axis: Axis.horizontal,
                          shipType: shipType,
                          cellHeight: draggedCellHeight,
                        ),
                        child: ShipWidget(
                          axis: Axis.horizontal,
                          shipType: shipType,
                          cellHeight: defaultCellHeight,
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('x $count'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
