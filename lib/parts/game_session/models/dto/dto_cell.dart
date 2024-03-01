part of '../../game_session_part.dart';

@JsonSerializable()
class DtoCell {
  final int index;
  final int state;

  const DtoCell({
    required this.index,
    required this.state,
  });

  factory DtoCell.fromJson(Map<String, dynamic> json) =>
      _$DtoCellFromJson(json);

  Map<String, dynamic> toJson() => _$DtoCellToJson(this);
}
