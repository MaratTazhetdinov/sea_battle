part of '../../game_session_part.dart';

@JsonSerializable(
  explicitToJson: true,
)
class DtoGameSession {
  final DtoGameBoard? firstPlayerBoard;
  final DtoGameBoard? secondPlayerBoard;

  const DtoGameSession({
    this.firstPlayerBoard,
    this.secondPlayerBoard,
  });

  factory DtoGameSession.fromJson(Map<String, dynamic> json) =>
      _$DtoGameSessionFromJson(json);

  Map<String, dynamic> toJson() => _$DtoGameSessionToJson(this);
}
