// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_session_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DtoGameSession _$DtoGameSessionFromJson(Map<String, dynamic> json) =>
    DtoGameSession(
      firstPlayer: json['firstPlayer'] == null
          ? null
          : UserModel.fromJson(json['firstPlayer'] as Map<String, dynamic>),
      firstPlayerBoard: DtoGameSession._playerBoardFromJson(
          json['firstPlayerBoard'] as Map<String, dynamic>?),
      secondPlayer: json['secondPlayer'] == null
          ? null
          : UserModel.fromJson(json['secondPlayer'] as Map<String, dynamic>),
      secondPlayerBoard: DtoGameSession._playerBoardFromJson(
          json['secondPlayerBoard'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$DtoGameSessionToJson(DtoGameSession instance) =>
    <String, dynamic>{
      'firstPlayer': instance.firstPlayer?.toJson(),
      'firstPlayerBoard':
          DtoGameSession._playerBoardToJson(instance.firstPlayerBoard),
      'secondPlayer': instance.secondPlayer?.toJson(),
      'secondPlayerBoard':
          DtoGameSession._playerBoardToJson(instance.secondPlayerBoard),
    };

DtoCell _$DtoCellFromJson(Map<String, dynamic> json) => DtoCell(
      state: json['state'] as int,
    );

Map<String, dynamic> _$DtoCellToJson(DtoCell instance) => <String, dynamic>{
      'state': instance.state,
    };
