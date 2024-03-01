part of '../game_session_part.dart';

abstract class IGameSessionDataProvider {
  Stream<DtoGameSession> get gameSession;

  Future<void> shoot();
}
