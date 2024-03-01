// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_session_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DtoGameSession _$DtoGameSessionFromJson(Map<String, dynamic> json) =>
    DtoGameSession(
      firstPlayerBoard: json['firstPlayerBoard'] == null
          ? null
          : DtoGameBoard.fromJson(
              json['firstPlayerBoard'] as Map<String, dynamic>),
      secondPlayerBoard: json['secondPlayerBoard'] == null
          ? null
          : DtoGameBoard.fromJson(
              json['secondPlayerBoard'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DtoGameSessionToJson(DtoGameSession instance) =>
    <String, dynamic>{
      'firstPlayerBoard': instance.firstPlayerBoard?.toJson(),
      'secondPlayerBoard': instance.secondPlayerBoard?.toJson(),
    };

DtoGameBoard _$DtoGameBoardFromJson(Map<String, dynamic> json) => DtoGameBoard(
      userId: json['userId'] as String,
      userNickname: json['userNickname'] as String,
      cells: (json['cells'] as List<dynamic>)
          .map((e) => DtoCell.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DtoGameBoardToJson(DtoGameBoard instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userNickname': instance.userNickname,
      'cells': instance.cells,
    };

DtoCell _$DtoCellFromJson(Map<String, dynamic> json) => DtoCell(
      index: json['index'] as int,
      state: json['state'] as int,
    );

Map<String, dynamic> _$DtoCellToJson(DtoCell instance) => <String, dynamic>{
      'index': instance.index,
      'state': instance.state,
    };
