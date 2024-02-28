part of '../../game_session_part.dart';

@JsonSerializable(
  explicitToJson: true,
)
class DtoGameSession {
  final UserModel? firstPlayer;
  @JsonKey(
    toJson: _playerBoardToJson,
    fromJson: _playerBoardFromJson,
  )
  final List<DtoCell>? firstPlayerBoard;
  final UserModel? secondPlayer;
  @JsonKey(
    toJson: _playerBoardToJson,
    fromJson: _playerBoardFromJson,
  )
  final List<DtoCell>? secondPlayerBoard;

  const DtoGameSession({
    this.firstPlayer,
    this.firstPlayerBoard,
    this.secondPlayer,
    this.secondPlayerBoard,
  });

  factory DtoGameSession.fromJson(Map<String, dynamic> json) =>
      _$DtoGameSessionFromJson(json);

  Map<String, dynamic> toJson() => _$DtoGameSessionToJson(this);

  static Map<String, dynamic> _playerBoardToJson(List<DtoCell>? playerBoard) {
    final Map<String, dynamic> json = {};
    if (playerBoard case final playerBoard?) {
      for (int i = 0; i < playerBoard.length; i++) {
        json[i.toString()] = playerBoard[i].state;
      }
    }
    return json;
  }

  static List<DtoCell>? _playerBoardFromJson(Map<String, dynamic>? json) {
    if (json case final json?) {
      final List<DtoCell> playerBoard = [];
      for (int i = 0; i < 99; i++) {
        playerBoard.add(json[i.toString()]);
      }
      return playerBoard;
    } else {
      return null;
    }
  }
}
