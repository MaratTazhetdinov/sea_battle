part of '../profile_part.dart';

class FirestoreProfileDataProvider extends IProfileDataProvider {
  final FirebaseFirestore db;
  static const collectionPath = 'profiles';

  FirestoreProfileDataProvider({required this.db});

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> _getDocByUserId(
      {required String id}) {
    return db.collection(collectionPath).get().then((value) =>
        value.docs.firstWhereOrNull((element) => element['id'] == id));
  }

  @override
  Future<DtoProfile?> getProfileById({required String id}) async {
    DtoProfile? dtoProfile;
    final doc = await _getDocByUserId(id: id);
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
      'win': dtoProfile.win,
      'loss': dtoProfile.loss,
    });
  }

  @override
  Future<bool> isNicknameInUse({required String nickname}) async {
    final doc = await db.collection(collectionPath).get().then((value) => value
        .docs
        .firstWhereOrNull((element) => element['nickname'] == nickname));
    return doc != null;
  }

  @override
  Future<void> updateProfileStatistic(
      {required bool isWinner, required String id}) async {
    final doc = await _getDocByUserId(id: id);
    if (doc case final doc?) {
      final profileId = doc.id;
      final profile = await getProfileById(id: id);
      if (profile case final profile?) {
        if (isWinner) {
          final winsCount = profile.win + 1;
          await db
              .collection(collectionPath)
              .doc(profileId)
              .update({'win': winsCount});
        } else {
          final lossCount = profile.loss + 1;
          await db
              .collection(collectionPath)
              .doc(profileId)
              .update({'loss': lossCount});
        }
      }
    }
  }
}
