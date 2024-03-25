part of '../ships_alignment_part.dart';

@RoutePage()
class ShipsAlignmentScreen extends StatefulWidget {
  const ShipsAlignmentScreen({super.key});

  @override
  State<ShipsAlignmentScreen> createState() => _ShipsAlignmentScreenState();
}

class _ShipsAlignmentScreenState extends State<ShipsAlignmentScreen> {
  ValueNotifier<Map<ShipType, int>> shipCounter =
      ValueNotifier<Map<ShipType, int>>({
    ShipType.one: 4,
    ShipType.two: 3,
    ShipType.three: 2,
    ShipType.four: 1,
  });

  ValueNotifier<bool> userIsDragging = ValueNotifier<bool>(false);

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
                    userIsDragging: userIsDragging,
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
                                  current.cellCount > next.cellCount
                                      ? current
                                      : next)
                              .cellCount;
                      return Column(
                        children: [
                          ...ShipType.values.reversed.map(
                            (shipType) => ShipPickerWidget(
                              widgetHeight: widgetHeight,
                              defaultCellHeight: cellHeight,
                              draggedCellHeight: draggedCellHeight,
                              shipType: shipType,
                              shipCounter: shipCounter,
                              userIsDragging: userIsDragging,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 50,
                    child: ValueListenableBuilder<Map<ShipType, int>>(
                      valueListenable: shipCounter,
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
