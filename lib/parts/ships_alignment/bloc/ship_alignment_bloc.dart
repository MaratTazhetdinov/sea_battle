part of '../ships_alignment_part.dart';

class ShipAlignmentBloc extends Bloc<ShipAlignmentEvent, ShipAlignmentState> {
  final Board board;
  final ShipCounter shipCounter;

  ShipAlignmentBloc({required this.board, required this.shipCounter})
      : super(ShipAlignmentState(
          board: board,
          shipCounter: shipCounter,
        )) {
    on<ShipRemovedByIndex>(_onShipRemovedByIndex);
    on<ShipAddedByIndexes>(_onShipAddedByIndexes);
  }

  void _onShipRemovedByIndex(
      ShipRemovedByIndex event, Emitter<ShipAlignmentState> emit) {
    ///TODO CHECK
    final ship = state.board.detectShipByIndex(event.index);
    final updatedBoardCell = state.board.removeShipByIndex(event.index);
    final updatedBoard = state.board.copyWith(boardCell: updatedBoardCell);
    final updatedCounterMap = state.shipCounter.addShip(ship.shipType);
    final updatedShipCounter =
        state.shipCounter.copyWith(counterMap: updatedCounterMap);
    print(
        state.copyWith(board: updatedBoard, shipCounter: updatedShipCounter) ==
            state);
    emit(state.copyWith(board: updatedBoard, shipCounter: updatedShipCounter));
  }

  void _onShipAddedByIndexes(
      ShipAddedByIndexes event, Emitter<ShipAlignmentState> emit) {
    final updatedBoardCell = state.board.addShipToBoard(event.indexes);
    final updatedBoard = state.board.copyWith(boardCell: updatedBoardCell);
    final updatedCounterMap = state.shipCounter.removeShip(ShipType.values
        .firstWhere((shipType) => shipType.size == event.indexes.length));
    final updatedShipCounter =
        state.shipCounter.copyWith(counterMap: updatedCounterMap);
    emit(state.copyWith(board: updatedBoard, shipCounter: updatedShipCounter));
  }
}

/// Context extension for quick access to [ShipAlignmentBloc].
extension ShipAlignmentBlocBuildContextX on BuildContext {
  /// Instance of [ShipAlignmentBloc].
  ShipAlignmentBloc get readShipAlignmentBloc => read<ShipAlignmentBloc>();
}
