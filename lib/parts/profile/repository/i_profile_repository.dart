part of '../profile_part.dart';

abstract class IProfileRepository {
  Future<Profile?> getProfileById({required String id});

  Future<List<Profile>> getAllProfiles();

  Future<void> createProfile({required Profile profile});

  Future<bool> isNicknameInUse({required String nickname});
}
