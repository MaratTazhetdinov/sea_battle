part of '../ships_alignment_part.dart';

/// Bloc for ship alignment.
class ShipsAlignmentBloc
    extends Bloc<ShipsAlignmentEvent, ShipsAlignmentState> {
  /// [GameBoard].
  final GameBoard board;

  /// [ShipCounter].
  final ShipCounter shipCounter;

  /// Game session repository to interact with backend.
  final game_session.IGameSessionRepository gameSessionRepository;

  ShipsAlignmentBloc({
    required this.board,
    required this.shipCounter,
    required this.gameSessionRepository,
  }) : super(ShipsAlignmentState(
          board: board,
          shipCounter: shipCounter,
        )) {
    on<ShipRemovedByIndex>(_onShipRemovedByIndex);
    on<ShipAddedByIndexes>(_onShipAddedByIndexes);
    on<ShipsAlignmentCompleted>(_onShipAlignmentCompleted);
  }

  /// Removes ship by [index] from [Board].
  void _onShipRemovedByIndex(
      ShipRemovedByIndex event, Emitter<ShipsAlignmentState> emit) {
    final ship = state.board.detectShipByIndex(event.index);
    final updatedBoardCell = state.board.removeShipByIndex(event.index);
    final updatedBoard = state.board.copyWith(gameBoardCell: updatedBoardCell);
    final updatedCounterMap = state.shipCounter.addShip(ship.shipType);
    final updatedShipCounter =
        state.shipCounter.copyWith(counterMap: updatedCounterMap);
    emit(state.copyWith(board: updatedBoard, shipCounter: updatedShipCounter));
  }

  /// Adds ship by list of indexes to [Board].
  void _onShipAddedByIndexes(
      ShipAddedByIndexes event, Emitter<ShipsAlignmentState> emit) {
    final updatedBoardCell = state.board.addShipToBoard(event.indexes);
    final updatedBoard = state.board.copyWith(gameBoardCell: updatedBoardCell);
    final updatedCounterMap = state.shipCounter.removeShip(ShipType.values
        .firstWhere((shipType) => shipType.size == event.indexes.length));
    final updatedShipCounter =
        state.shipCounter.copyWith(counterMap: updatedCounterMap);
    emit(state.copyWith(board: updatedBoard, shipCounter: updatedShipCounter));
  }

  /// Sends result of completed ships data to backend.
  Future<void> _onShipAlignmentCompleted(
      ShipsAlignmentCompleted event, Emitter<ShipsAlignmentState> emit) async {
    await gameSessionRepository.finishShipsAlignment(
        userId: event.userId, cells: event.cells);
  }
}

/// Context extension for quick access to [ShipsAlignmentBloc].
extension ShipsAlignmentBlocBuildContextX on BuildContext {
  /// Instance of [ShipsAlignmentBloc].
  ShipsAlignmentBloc get readShipAlignmentBloc => read<ShipsAlignmentBloc>();
}
