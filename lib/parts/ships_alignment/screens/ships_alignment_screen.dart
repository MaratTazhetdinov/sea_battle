part of '../ships_alignment_part.dart';

@RoutePage()
class ShipsAlignmentScreen extends StatefulWidget {
  const ShipsAlignmentScreen({super.key});

  @override
  State<ShipsAlignmentScreen> createState() => _ShipsAlignmentScreenState();
}

class _ShipsAlignmentScreenState extends State<ShipsAlignmentScreen> {
  final ValueNotifier<Map<ShipType, int>> _shipCounter =
      ValueNotifier<Map<ShipType, int>>({
    ShipType.one: 4,
    ShipType.two: 3,
    ShipType.three: 2,
    ShipType.four: 1,
  });

  final ValueNotifier<DraggableShip> _draggableShip =
      ValueNotifier<DraggableShip>(DraggableShip.empty());

  final ValueNotifier<List<int>> _potentialIndexes =
      ValueNotifier<List<int>>([]);
  final _board = Board(cellsNumber: 100);

  @override
  void dispose() {
    _shipCounter.dispose();
    _draggableShip.dispose();
    _potentialIndexes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ships Alignment'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final draggedCellHeight = (constraints.maxWidth / 10) * 1.25;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AlignmentBoardWidget(
                    boardSize: Size(constraints.maxWidth, constraints.maxWidth),
                    draggableShip: _draggableShip,
                    potentialIndexes: _potentialIndexes,
                    board: _board,
                  ),
                  const SizedBox(height: 20),
                  Builder(
                    builder: (context) {
                      final height = constraints.maxHeight -
                          constraints.maxWidth -
                          20 -
                          50;
                      final widgetHeight = height / ShipType.values.length;
                      final cellHeight = (widgetHeight - 10) /
                          ShipType.values
                              .reduce((current, next) =>
                                  current.size > next.size ? current : next)
                              .size;
                      return Column(
                        children: [
                          ...ShipType.values.reversed.map(
                            (shipType) => ShipPickerWidget(
                              widgetHeight: widgetHeight,
                              defaultCellHeight: cellHeight,
                              draggedCellHeight: draggedCellHeight,
                              shipType: shipType,
                              shipCounter: _shipCounter,
                              draggableShip: _draggableShip,
                              potentialIndexes: _potentialIndexes,
                              board: _board,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 50,
                    child: ValueListenableBuilder<Map<ShipType, int>>(
                      valueListenable: _shipCounter,
                      builder: (context, value, _) {
                        return ElevatedButton(
                          onPressed: value.values.every((count) => count == 0)
                              ? () {}
                              : null,
                          child: const Text(
                            'Start battle',
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
