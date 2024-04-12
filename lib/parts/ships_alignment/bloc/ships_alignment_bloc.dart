part of '../ships_alignment_part.dart';

/// Bloc for ship alignment.
class ShipsAlignmentBloc
    extends Bloc<ShipsAlignmentEvent, ShipsAlignmentState> {
  /// [GameBoard].
  final GameBoard gameBoard;

  /// [ShipCounter].
  final ShipCounter shipCounter;

  /// Game session repository to interact with backend.
  final IGameSessionRepository gameSessionRepository;

  ShipsAlignmentBloc({
    required this.gameBoard,
    required this.shipCounter,
    required this.gameSessionRepository,
  }) : super(ShipsAlignmentState(
          gameBoard: gameBoard,
          shipCounter: shipCounter,
        )) {
    on<ShipRemovedByIndexes>(_onShipRemovedByIndexes);
    on<ShipAddedByIndexes>(_onShipAddedByIndexes);
    on<ShipsAlignmentCompleted>(_onShipAlignmentCompleted);
  }

  /// Removes ship by [index] from [Board].
  void _onShipRemovedByIndexes(
      ShipRemovedByIndexes event, Emitter<ShipsAlignmentState> emit) {
    final newGameBoard = _removeShipByIndexes(
        indexes: event.indexes, gameBoard: state.gameBoard);
    final ship = Ship.fromIndexes(event.indexes);
    final newShipCounter = state.shipCounter.addShip(ship.shipType);
    final newState = ShipsAlignmentState(
        gameBoard: newGameBoard, shipCounter: newShipCounter);
    emit(newState);
  }

  /// Adds ship by list of indexes to [Board].
  void _onShipAddedByIndexes(
      ShipAddedByIndexes event, Emitter<ShipsAlignmentState> emit) {
    final newGameBoard =
        _addShipToGameBoard(indexes: event.indexes, gameBoard: state.gameBoard);
    final ship = Ship.fromIndexes(event.indexes);
    final newShipCounter = state.shipCounter.removeShip(ship.shipType);
    final newState = ShipsAlignmentState(
        gameBoard: newGameBoard, shipCounter: newShipCounter);
    emit(newState);
  }

  /// Sends result of completed ships data to backend.
  Future<void> _onShipAlignmentCompleted(
      ShipsAlignmentCompleted event, Emitter<ShipsAlignmentState> emit) async {
    final occupiedCells = state.gameBoard.cell.findOccupiedIndexes();
    try {
      await gameSessionRepository.finishShipsAlignment(
        userId: state.gameBoard.userId,
        gameSessionId: event.gameSessionId,
        cells: occupiedCells,
      );
      emit(state.copyWith(isAlignmentComplited: true));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Removes ship from [GameBoard] with given [index].
  GameBoard _removeShipByIndexes({
    required List<int> indexes,
    required GameBoard gameBoard,
  }) {
    Cell newCell = gameBoard.cell;
    for (int i = 0; i < indexes.length; i++) {
      newCell = newCell.goToCellWithIndex(indexes[i]);
      newCell.setCellState = CellState.empty;
    }
    return gameBoard.copyWith(cell: newCell);
  }

  /// Adds ship to [GameBoard] with given [indexes].
  GameBoard _addShipToGameBoard({
    required List<int> indexes,
    required GameBoard gameBoard,
  }) {
    Cell newCell = gameBoard.cell;
    for (int i = 0; i < indexes.length; i++) {
      newCell = newCell.goToCellWithIndex(indexes[i]);
      newCell.setCellState = CellState.occupied;
    }
    return gameBoard.copyWith(cell: newCell);
  }
}

/// Context extension for quick access to [ShipsAlignmentBloc].
extension ShipsAlignmentBlocBuildContextX on BuildContext {
  /// Instance of [ShipsAlignmentBloc].
  ShipsAlignmentBloc get readShipAlignmentBloc => read<ShipsAlignmentBloc>();
}
