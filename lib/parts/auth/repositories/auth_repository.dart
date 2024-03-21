part of '../auth_part.dart';

class AuthRepository extends IAuthRepository {
  final IAuthDataProvider iAuthDataProvider;

  AuthRepository({required this.iAuthDataProvider});

  @override
  Stream<UserModel> get user => iAuthDataProvider.user;

  @override
  Future<String?> signUpByEmailAndPassword(
      {required String email, required String password}) async {
    return await iAuthDataProvider.signUpByEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signInByEmailAndPassword(
      {required String email, required String password}) async {
    await iAuthDataProvider.signInByEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await iAuthDataProvider.signOut();
  }
}
