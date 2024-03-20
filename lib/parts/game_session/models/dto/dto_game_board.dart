part of '../../game_session_part.dart';

class DtoGameBoard {
  final String userId;
  final List<int> cells;

  const DtoGameBoard({
    required this.userId,
    required this.cells,
  });

  // factory DtoGameBoard.fromFirebaseDatabase(Map<Object?, Object?> data) {
  //   final json = Map<String, dynamic>.from(data);
  //   final cells = List<int>.from(json['cells'] as List<Object?>);
  //   return DtoGameBoard(
  //     userId: json['userId'],
  //     cells: cells,
  //   );
  // }
}
