part of '../profile_part.dart';

class FirestoreProfileDataProvider extends IProfileDataProvider {
  final FirebaseFirestore db;
  static const collectionPath = 'profiles';

  FirestoreProfileDataProvider({required this.db});

  @override
  Future<DtoProfile?> getProfileById({required String id}) async {
    DtoProfile? dtoProfile;
    final doc = await db.collection(collectionPath).get().then((value) =>
        value.docs.firstWhereOrNull((element) => element['id'] == id));
    if (doc?.data() case final json?) {
      dtoProfile = DtoProfile.fromJson(json);
    }
    return dtoProfile;
  }

  @override
  Future<List<DtoProfile>> getAllProfiles() async {
    final collection = await db.collection(collectionPath).get();
    return collection.docs
        .map((element) => DtoProfile.fromJson(element.data()))
        .toList();
  }

  @override
  Future<void> createProfile({required DtoProfile dtoProfile}) async {
    await db.collection(collectionPath).add({
      'id': dtoProfile.id,
      'email': dtoProfile.email,
      'nickname': dtoProfile.nickname,
    });
  }

  @override
  Future<bool> isNicknameInUse({required String nickname}) async {
    final doc = await db.collection(collectionPath).get().then((value) => value
        .docs
        .firstWhereOrNull((element) => element['nickname'] == nickname));
    return doc != null;
  }
}
