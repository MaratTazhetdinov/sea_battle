part of '../auth_part.dart';

class FirebaseAuthDataProvider extends IAuthDataProvider {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthDataProvider({required this.firebaseAuth});

  @override
  Stream<UserModel> get user =>
      firebaseAuth.authStateChanges().map((firebaseUser) {
        if (firebaseUser case final user?) {
          return UserModel.fromFirebaseUser(firebaseUser: user);
        } else {
          return UserModel.empty;
        }
      });

  @override
  Future<String?> signUpByEmailAndPassword(
      {required String email, required String password}) async {
    final userCredentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredentials.user?.uid;
  }

  @override
  Future<void> signInByEmailAndPassword(
      {required String email, required String password}) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
