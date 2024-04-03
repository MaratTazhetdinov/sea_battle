part of '../ships_alignment_part.dart';

class ShipPickerWidget extends StatefulWidget {
  final double widgetHeight;
  final double cellHeight;
  final ShipType shipType;
  final Function(DragStartDetails, Ship) onPanStart;
  final Function(DragUpdateDetails) onPanUpdate;
  final Function(DragEndDetails, BuildContext) onPanEnd;

  const ShipPickerWidget({
    super.key,
    required this.widgetHeight,
    required this.cellHeight,
    required this.shipType,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
  });

  @override
  State<ShipPickerWidget> createState() => _ShipPickerWidgetState();
}

class _ShipPickerWidgetState extends State<ShipPickerWidget> {
  @override
  Widget build(BuildContext context) {
    final shipType = widget.shipType;
    final cellHeight = widget.cellHeight;
    return SizedBox(
      height: widget.widgetHeight,
      child: BlocBuilder<ShipsAlignmentBloc, ShipsAlignmentState>(
        builder: (context, state) {
          final count = state.shipCounter.counterMap[shipType];
          final verticalShip =
              Ship(shipType: shipType, shipAxis: Axis.vertical);
          final horizontalShip =
              Ship(shipType: shipType, shipAxis: Axis.horizontal);
          return AbsorbPointer(
            absorbing: count == 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onPanStart: (details) =>
                          widget.onPanStart(details, verticalShip),
                      onPanUpdate: (details) => widget.onPanUpdate(details),
                      onPanEnd: (details) => widget.onPanEnd(details, context),
                      child: ShipWidget(
                        ship: verticalShip,
                        cellHeight: cellHeight,
                      ),
                    ),
                    if (shipType != ShipType.one)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('or'),
                      ),
                    if (shipType != ShipType.one)
                      GestureDetector(
                        onPanStart: (details) =>
                            widget.onPanStart(details, horizontalShip),
                        onPanUpdate: (details) => widget.onPanUpdate(details),
                        onPanEnd: (details) =>
                            widget.onPanEnd(details, context),
                        child: ShipWidget(
                          ship: horizontalShip,
                          cellHeight: cellHeight,
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