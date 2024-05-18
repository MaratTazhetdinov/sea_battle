part of '../profile_part.dart';

class ProfileRepository extends IProfileRepository {
  final IProfileDataProvider iProfileDataProvider;

  ProfileRepository({required this.iProfileDataProvider});

  @override
  Future<Profile?> getProfileById({required String id}) async {
    Profile? profile;
    final dtoProfile = await iProfileDataProvider.getProfileById(id: id);
    if (dtoProfile case final dtoProfile?) {
      profile = Profile.fromDto(dtoProfile);
    }
    return profile;
  }

  @override
  Future<List<Profile>> getAllProfiles() async {
    final List<Profile> profilesList = [];
    final dtoProfilesList = await iProfileDataProvider.getAllProfiles();
    for (DtoProfile dtoProfile in dtoProfilesList) {
      profilesList.add(Profile.fromDto(dtoProfile));
    }
    return profilesList;
  }

  @override
  Future<void> createProfile({required Profile profile}) async {
    await iProfileDataProvider.createProfile(dtoProfile: profile.toDto());
  }

  @override
  Future<bool> isNicknameInUse({required String nickname}) async {
    return iProfileDataProvider.isNicknameInUse(nickname: nickname);
  }

  @override
  Future<void> updateProfileStatistic(
      {required bool isWinner, required String id}) async {
    await iProfileDataProvider.updateProfileStatistic(
        isWinner: isWinner, id: id);
  }
}
