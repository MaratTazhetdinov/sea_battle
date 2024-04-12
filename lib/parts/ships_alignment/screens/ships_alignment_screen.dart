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

  /// Value notifier of list of possible indexes for [DraggableShip] on [GameBoard].
  final ValueNotifier<List<int>> _possibleIndexes =
      ValueNotifier<List<int>>([]);

  @override
  void dispose() {
    _draggableShip.dispose();
    _possibleIndexes.dispose();
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
    if (_possibleIndexes.value.isNotEmpty) {
      context.readShipAlignmentBloc
          .add(ShipAddedByIndexes(_possibleIndexes.value));
      _possibleIndexes.value = [];
    }
    _draggableShip.value = const DraggableShip.empty();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.l10n;
    const double horizontalPadding = 40;
    final user = context.readAuthBloc.state.user;

    return BlocProvider(
      create: (context) => ShipsAlignmentBloc(
        gameBoard: GameBoard.create(user.id, user.nickname),
        shipCounter: ShipCounter.create(),
        gameSessionRepository:
            RepositoryProvider.of<IGameSessionRepository>(context),
      ),
      child: BlocListener<ShipsAlignmentBloc, ShipsAlignmentState>(
        listener: (context, state) {
          if (state.isAlignmentComplited) {
            context.router.replace(const GameSessionRoute());
          }
        },
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text(locale.lineUpYourShips),
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
                            gameBoardSize: Size(
                                constraints.maxWidth, constraints.maxWidth),
                            draggableShip: _draggableShip,
                            possibleIndexes: _possibleIndexes,
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
                                      .skip(1)
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
                                          context.readShipAlignmentBloc.add(
                                            ShipsAlignmentCompleted(),
                                          );
                                        }
                                      : null,
                                  child: Text(locale.startBattle),
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
            LayoutBuilder(
              builder: (context, constraint) {
                final draggedCellHeight =
                    ((constraint.maxWidth - (horizontalPadding * 2)) / 10) *
                        1.25;
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
