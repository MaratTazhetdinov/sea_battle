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
  final ValueNotifier<bool> userIsDragging;
  const ShipPickerWidget({
    super.key,
    required this.widgetHeight,
    required this.defaultCellHeight,
    required this.draggedCellHeight,
    required this.shipType,
    required this.shipCounter,
    required this.userIsDragging,
  });

  @override
  State<ShipPickerWidget> createState() => _ShipPickerWidgetState();
}

class _ShipPickerWidgetState extends State<ShipPickerWidget> {
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
                      onDragStarted: () => widget.userIsDragging.value = true,
                      onDraggableCanceled: (p0, p1) =>
                          widget.userIsDragging.value = false,
                      onDragEnd: (_) => widget.userIsDragging.value = false,
                    ),
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
