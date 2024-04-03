part of '../ships_alignment_part.dart';

@RoutePage()

/// [ShipsAlignmentScreen].
class ShipsAlignmentScreen extends StatefulWidget {
  const ShipsAlignmentScreen({super.key});

  @override
  State<ShipsAlignmentScreen> createState() => _ShipsAlignmentScreenState();
}

class _ShipsAlignmentScreenState extends State<ShipsAlignmentScreen> {
  /// Value notifier of [DraggableShip].
  final ValueNotifier<DraggableShip> _draggableShip =
      ValueNotifier<DraggableShip>(const DraggableShip.empty());

  /// Value notifier of list of potentialIndexes for [DraggableShip] on [GameBoard].
  final ValueNotifier<List<int>> _potentialIndexes =
      ValueNotifier<List<int>>([]);

  @override
  void dispose() {
    _draggableShip.dispose();
    _potentialIndexes.dispose();
    super.dispose();
  }

  /// OnPanStart function.
  void _onPanStart(DragStartDetails details, Ship ship) {
    _draggableShip.value = DraggableShip(
      ship: ship,
      offset: details.globalPosition,
    );
  }

  /// OnPanUpdate function.
  void _onPanUpdate(DragUpdateDetails details) {
    _draggableShip.value =
        _draggableShip.value.copyWith(offset: details.globalPosition);
  }

  /// OnPanEnd function.
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
    final userId = context.readAuthBloc.state.user.id;
    final sessionId =
        DateTime.now().millisecondsSinceEpoch + Random().nextInt(1000);
    return BlocProvider(
      create: (context) => ShipsAlignmentBloc(
        board: GameBoard.create(userId),
        shipCounter: ShipCounter.create(),
        gameSessionRepository: game_session.FbDbGameSessionRepository(
          fbDbDataProvider: game_session.FbDbGameSessionDataProvider(
            gameSessionId: sessionId.toString(),
            db: FirebaseDatabase.instance,
          ),
        ),
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
                        AlignmentGameBoardWidget(
                          gameBoardSize:
                              Size(constraints.maxWidth, constraints.maxWidth),
                          draggableShip: _draggableShip,
                          potentialIndexes: _potentialIndexes,
                          onPanStart: (details, ship) =>
                              _onPanStart(details, ship),
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
                                ...ShipType.values
                                    .skip(0)
                                    .toList()
                                    .reversed
                                    .map(
                                      (shipType) => ShipPickerWidget(
                                        widgetHeight: widgetHeight,
                                        cellHeight: cellHeight,
                                        shipType: shipType,
                                        onPanStart: (details, ship) =>
                                            _onPanStart(details, ship),
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
                        BlocBuilder<ShipsAlignmentBloc, ShipsAlignmentState>(
                          builder: (context, state) {
                            return SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: state.shipCounter.isEmpty
                                    ? () {
                                        final userId =
                                            context.readAuthBloc.state.user.id;
                                        context.readShipAlignmentBloc.add(
                                          ShipsAlignmentCompleted(
                                            userId: userId,
                                            cells: state.board
                                                .findOccupiedIndexes(),
                                          ),
                                        );
                                      }
                                    : null,
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
