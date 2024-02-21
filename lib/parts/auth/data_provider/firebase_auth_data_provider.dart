part of '../auth_part.dart';

class FirebaseDataProvider extends IAuthDataProvider {
  final FirebaseAuth firebaseAuth;

  FirebaseDataProvider({required this.firebaseAuth});

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
  Future<void> signUpByEmailAndPassword(
      {required String email, required String password}) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
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
