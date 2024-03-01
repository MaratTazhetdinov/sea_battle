part of '../../game_session_part.dart';

@JsonSerializable()
class DtoGameBoard {
  final String userId;
  final String userNickname;
  final List<DtoCell> cells;

  const DtoGameBoard({
    required this.userId,
    required this.userNickname,
    required this.cells,
  });

  factory DtoGameBoard.fromJson(Map<String, dynamic> json) =>
      _$DtoGameBoardFromJson(json);

  Map<String, dynamic> toJson() => _$DtoGameBoardToJson(this);
}
