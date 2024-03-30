part of '../ships_alignment_part.dart';

@RoutePage()
class ShipsAlignmentScreen extends StatefulWidget {
  const ShipsAlignmentScreen({super.key});

  @override
  State<ShipsAlignmentScreen> createState() => _ShipsAlignmentScreenState();
}

class _ShipsAlignmentScreenState extends State<ShipsAlignmentScreen> {
  final ValueNotifier<DraggableShip> _draggableShip =
      ValueNotifier<DraggableShip>(const DraggableShip.empty());

  final ValueNotifier<List<int>> _potentialIndexes =
      ValueNotifier<List<int>>([]);

  @override
  void dispose() {
    _draggableShip.dispose();
    _potentialIndexes.dispose();
    super.dispose();
  }

  void _onPanStarted(DragStartDetails details, Ship ship) {
    _draggableShip.value = DraggableShip(
      ship: ship,
      offset: details.globalPosition,
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _draggableShip.value =
        _draggableShip.value.copyWith(offset: details.globalPosition);
  }

  void _onPanEnd(DragEndDetails details, BuildContext context) {
    if (_potentialIndexes.value.isNotEmpty) {
      context.readShipAlignmentBloc
          .add(ShipAddedByIndexes(_potentialIndexes.value));
      _potentialIndexes.value = [];
    }
    _draggableShip.value = const DraggableShip.empty();
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 40;
    return BlocProvider(
      create: (context) => ShipAlignmentBloc(
        board: Board.factory(),
        shipCounter: ShipCounter.factory(),
      ),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text('Ships Alignment'),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: horizontalPadding),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AlignmentBoardWidget(
                          boardSize:
                              Size(constraints.maxWidth, constraints.maxWidth),
                          draggableShip: _draggableShip,
                          potentialIndexes: _potentialIndexes,
                          onPanStart: (details, ship) =>
                              _onPanStarted(details, ship),
                          onPanUpdate: (details) => _onPanUpdate(details),
                          onPanEnd: (details, context) =>
                              _onPanEnd(details, context),
                        ),
                        const SizedBox(height: 20),
                        Builder(
                          builder: (context) {
                            final height = constraints.maxHeight -
                                constraints.maxWidth -
                                20 -
                                50;
                            final widgetHeight =
                                height / ShipType.values.length;
                            final cellHeight = (widgetHeight - 10) /
                                ShipType.values
                                    .reduce((current, next) =>
                                        current.size > next.size
                                            ? current
                                            : next)
                                    .size;
                            return Column(
                              children: [
                                ...ShipType.values.reversed.map(
                                  (shipType) => ShipPickerWidget(
                                    widgetHeight: widgetHeight,
                                    cellHeight: cellHeight,
                                    shipType: shipType,
                                    onPanStart: (details, ship) =>
                                        _onPanStarted(details, ship),
                                    onPanUpdate: (details) =>
                                        _onPanUpdate(details),
                                    onPanEnd: (details, context) =>
                                        _onPanEnd(details, context),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        BlocBuilder<ShipAlignmentBloc, ShipAlignmentState>(
                          builder: (context, state) {
                            return SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed:
                                    state.shipCounter.isEmpty ? () {} : null,
                                child: const Text(
                                  'Start battle',
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          LayoutBuilder(builder: (context, constraint) {
            final draggedCellHeight =
                ((constraint.maxWidth - (horizontalPadding * 2)) / 10) * 1.25;
            return ValueListenableBuilder(
              valueListenable: _draggableShip,
              builder: (context, draggableShip, _) {
                if (draggableShip == const DraggableShip.empty()) {
                  return const SizedBox.shrink();
                } else {
                  return Transform.translate(
                    offset: draggableShip.offset,
                    child: ShipWidget(
                      ship: draggableShip.ship,
                      cellHeight: draggedCellHeight,
                    ),
                  );
                }
              },
            );
          }),
        ],
      ),
    );
  }
}
