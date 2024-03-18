part of '../../game_session_part.dart';

class DtoGameBoard {
  final String userId;
  final String userNickname;
  final List<int> cells;

  const DtoGameBoard({
    required this.userId,
    required this.userNickname,
    required this.cells,
  });

  factory DtoGameBoard.fromFirebaseDatabase(Object? data) {
    final json = Map<String, dynamic>.from(data! as Map<Object?, Object?>);
    final cells = List<int>.from(json['cells'] as List<Object?>);
    return DtoGameBoard(
      userId: json['userId'],
      userNickname: json['userNickname'],
      cells: cells,
    );
  }
}
