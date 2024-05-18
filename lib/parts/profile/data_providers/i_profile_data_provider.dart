part of '../profile_part.dart';

abstract class IProfileDataProvider {
  Future<DtoProfile?> getProfileById({required String id});

  Future<List<DtoProfile>> getAllProfiles();

  Future<void> createProfile({required DtoProfile dtoProfile});

  Future<bool> isNicknameInUse({required String nickname});

  Future<void> updateProfileStatistic(
      {required bool isWinner, required String id});
}
