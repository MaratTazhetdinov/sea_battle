part of '../auth_part.dart';

class AuthRepository extends IAuthRepoistory {
  final IAuthDataProvider authDataProvider;

  AuthRepository({required this.authDataProvider});

  @override
  Stream<UserModel> get user => authDataProvider.user;

  @override
  Future<void> signUpByEmailAndPassword(
      {required String email, required String password}) async {
    await authDataProvider.signUpByEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signInByEmailAndPassword(
      {required String email, required String password}) async {
    await authDataProvider.signInByEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await authDataProvider.signOut();
  }
}
